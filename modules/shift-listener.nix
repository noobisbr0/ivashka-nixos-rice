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

        // Состояния для Shift
        int lshift = 0, rshift = 0, shift_active = 0;
        int shift_count = 0;
        struct timeval last_shift_press = {0, 0};

        // Состояния для Ctrl
        int lctrl = 0, rctrl = 0, ctrl_active = 0;
        int ctrl_count = 0;
        struct timeval last_ctrl_press = {0, 0};

        while (1) {
            int ret = poll(fds, num_fds, -1);
            if (ret <= 0) continue;

            for (int i = 0; i < num_fds; i++) {
                if (fds[i].revents & POLLIN) {
                    struct input_event ev;
                    while (read(fds[i].fd, &ev, sizeof(ev)) > 0) {
                        if (ev.type != EV_KEY) continue;

                        // 1. Обработка Shift
                        if (ev.code == KEY_LEFTSHIFT) {
                            lshift = (ev.value >= 1);
                        } else if (ev.code == KEY_RIGHTSHIFT) {
                            rshift = (ev.value >= 1);
                        }

                        // 2. Обработка Ctrl
                        if (ev.code == KEY_LEFTCTRL) {
                            lctrl = (ev.value >= 1);
                        } else if (ev.code == KEY_RIGHTCTRL) {
                            rctrl = (ev.value >= 1);
                        }

                        // Логика двойного Shift (x4)
                        if (lshift && rshift && !shift_active) {
                            shift_active = 1;
                            struct timeval now;
                            gettimeofday(&now, NULL);

                            if (shift_count == 0 || time_diff(&now, &last_shift_press) <= THRESHOLD_SEC) {
                                shift_count++;
                            } else {
                                shift_count = 1;
                            }
                            last_shift_press = now;

                            if (shift_count == REQUIRED_PRESSES) {
                                shift_count = 0;
                                if (fork() == 0) {
                                    system("notify-send -u normal 'Gemini' 'Открытие gemini.google.com...' && xdg-open https://gemini.google.com &");
                                    exit(0);
                                }
                            }
                        }
                        if (!lshift || !rshift) {
                            shift_active = 0;
                        }

                        // Логика двойного Ctrl (x4)
                        if (lctrl && rctrl && !ctrl_active) {
                            ctrl_active = 1;
                            struct timeval now;
                            gettimeofday(&now, NULL);

                            if (ctrl_count == 0 || time_diff(&now, &last_ctrl_press) <= THRESHOLD_SEC) {
                                ctrl_count++;
                            } else {
                                ctrl_count = 1;
                            }
                            last_ctrl_press = now;

                            if (ctrl_count == REQUIRED_PRESSES) {
                                ctrl_count = 0;
                                if (fork() == 0) {
                                    // Открываем окно kitty, запускаем fastfetch и оставляем терминал открытым
                                    system("kitty --title 'Fastfetch' bash -c 'fastfetch; exec bash' &");
                                    exit(0);
                                }
                            }
                        }
                        if (!lctrl || !rctrl) {
                            ctrl_active = 0;
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

  services.udev.extraRules = ''
    KERNEL=="event[08]", SUBSYSTEM=="input", MODE="0660", GROUP="users"
  '';
}
