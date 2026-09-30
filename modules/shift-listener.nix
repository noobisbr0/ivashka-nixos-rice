{ pkgs, ... }:

let
  shiftListener = pkgs.writeCBin "shift-listener" ''
    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <fcntl.h>
    #include <string.h>
    #include <poll.h>
    #include <linux/input.h>
    #include <sys/time.h>

    #define THRESHOLD_SEC 0.9
    #define REQUIRED_PRESSES 4
    #define MAX_FDS 4

    static inline double time_diff(struct timeval *t1, struct timeval *t2) {
        return (t1->tv_sec - t2->tv_sec) + (t1->tv_usec - t2->tv_usec) / 1000000.0;
    }

    int main() {
        const char *devices[] = {
            "/dev/input/event0", // AT Translated Set 2 keyboard
            "/dev/input/event8"  // ASUE1411 Keyboard
        };

        struct pollfd fds[MAX_FDS];
        int num_fds = 0;

        for (int i = 0; i < 2; i++) {
            int fd = open(devices[i], O_RDONLY | O_NONBLOCK);
            if (fd >= 0) {
                fds[num_fds].fd = fd;
                fds[num_fds].events = POLLIN;
                num_fds++;
            }
        }

        if (num_fds == 0) {
            return 1;
        }

        int lshift = 0, rshift = 0, both_active = 0;
        int count = 0;
        struct timeval last_press = {0, 0};

        while (1) {
            int ret = poll(fds, num_fds, -1);
            if (ret <= 0) continue;

            for (int i = 0; i < num_fds; i++) {
                if (fds[i].revents & POLLIN) {
                    struct input_event ev;
                    while (read(fds[i].fd, &ev, sizeof(ev)) > 0) {
                        if (ev.type != EV_KEY) continue;

                        if (ev.code == KEY_LEFTSHIFT) {
                            lshift = (ev.value >= 1);
                        } else if (ev.code == KEY_RIGHTSHIFT) {
                            rshift = (ev.value >= 1);
                        }

                        if (lshift && rshift && !both_active) {
                            both_active = 1;
                            struct timeval now;
                            gettimeofday(&now, NULL);

                            if (count == 0 || time_diff(&now, &last_press) <= THRESHOLD_SEC) {
                                count++;
                            } else {
                                count = 1;
                            }
                            last_press = now;

                            if (count == REQUIRED_PRESSES) {
                                count = 0;
                                if (fork() == 0) {
                                    // Прямой запуск от имени текущего пользователя в его сессии Hyprland
                                    system("notify-send -u normal 'Gemini' 'Открытие gemini.google.com...' && xdg-open https://gemini.google.com &");
                                    exit(0);
                                }
                            }
                        }

                        if (!lshift || !rshift) {
                            both_active = 0;
                        }
                    }
                }
            }
        }
        return 0;
    }
  '';
in
{
  environment.systemPackages = [ shiftListener ];

  # Разрешаем пользователям доступ на чтение событий клавиатуры без root
  services.udev.extraRules = ''
    KERNEL=="event[08]", SUBSYSTEM=="input", MODE="0660", GROUP="users"
  '';
}
