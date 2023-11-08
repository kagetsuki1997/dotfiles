{ config, ... }:

{
  config.programs.htop = {
    enable = true;
    settings = {
      fields = with config.lib.htop.fields; [
        PID
        USER
        PRIORITY
        NICE
        M_SIZE
        M_RESIDENT
        M_SHARE
        STATE
        PERCENT_CPU
        PERCENT_MEM
        TIME
        COMM
      ];

      sort_key = config.lib.htop.fields.PERCENT_CPU;
      sort_direction = 0;
      hide_threads = 1;
      hide_kernel_threads = 1;
      hide_userland_threads = 1;
      shadow_other_users = 0;
      show_thread_names = 1;
      show_program_path = 0;
      highlight_base_name = 1;
      highlight_megabytes = 1;
      highlight_threads = 1;
      tree_view = 1;
      header_margin = 1;
      detailed_cpu_time = 0;
      cpu_count_from_zero = 1;
      update_process_names = 0;
      account_guest_in_cpu_meter = 0;
      color_scheme = 0;
      delay = 15;
    } // (with config.lib.htop; leftMeters [
      (bar "AllCPUs2")
      (bar "Memory")
      (bar "Swap")
      (text "Zram")
    ]) // (with config.lib.htop; rightMeters [
      (text "Hostname")
      (text "System")
      (text "DateTime")
      (text "Uptime")
      (text "Systemd")
      (text "Tasks")
      (text "LoadAverage")
      (text "DiskIO")
      (text "NetworkIO")
      (text "Battery")
    ]);
  };

}

