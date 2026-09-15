{ ... }:

{
  # 1. Отключаем конфликтующий power-profiles-daemon
  services.power-profiles-daemon.enable = false;

  # 2. Комплексная настройка энергосбережения и бережной зарядки
  services.tlp = {
    enable = true;
    settings = {
      # Режимы работы процессора
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Отключение Turbo Boost на батарее (убирает пиковый нагрев)
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # Ограничение частоты до 75% для плавной отрисовки интерфейса без лагов
      CPU_MAX_PERF_ON_BAT = 75;

      # Энергосбережение звука, шин и периферии от АКБ
      SOUND_POWER_SAVE_ON_BAT = 1;
      WIFI_PWR_ON_BAT = "on";
      RUNTIME_PM_ON_BAT = "auto";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # Бережная зарядка: включение при <75%, остановка на 80%
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 95;
    };
  };
}
