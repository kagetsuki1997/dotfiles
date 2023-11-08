{ enableHiDPI ? false }:

{
  live_config_reload = true;
  draw_bold_text_with_bright_colors = true;
  debug.render_timer = false;

  env = {
    TERM = "xterm-256color";
  };

  cursor.style = "Underline";

  window = {
    dimensions = {
      columns = 80;
      lines = 24;
    };
    padding = {
      x = 2;
      y = 2;
    };
    decorations = "full";
    dynamic_title = true;
    opacity = 0.87;
  };

  font = {
    size = if enableHiDPI then 16.0 else 12.0;
    normal = { family = "Monaco"; style = "Regular"; };
    bold = { family = "Monaco"; style = "Regular"; };
    italic = { family = "monospace"; };
    offset = { x = 0; y = 0; };
    glyph_offset = { x = 0; y = 0; };
  };

  colors = {
    # Default colors
    primary = {
      background = "0x111111";
      foreground = "0xD0D0D0";
    };

    # Colors the cursor will use if `custom_cursor_colors` is true
    cursor = {
      text = "0x000000";
      cursor = "0x09A0F7";
    };

    # Normal colors
    normal = {
      black = "0x000000";
      red = "0xCD0000";
      green = "0x00CD00";
      yellow = "0xCDCD00";
      blue = "0x0000EE";
      magenta = "0xCD00CD";
      cyan = "0x00CDCD";
      white = "0xE5E5E5";
    };

    # Bright colors
    bright = {
      black = "0x7F7F7F";
      red = "0xFF0000";
      green = "0x00FF00";
      yellow = "0xFFFF00";
      blue = "0x5C5CFF";
      magenta = "0xFF00FF";
      cyan = "0x00FFFF";
      white = "0xFFFFFF";
    };

    # Dim colors (Optional)
    dim = {
      black = "0x333333";
      red = "0xF2777A";
      green = "0x99CC99";
      yellow = "0xFFCC66";
      blue = "0x6699CC";
      magenta = "0xCC99CC";
      cyan = "0x66CCCC";
      white = "0xDDDDDD";
    };
  };
}
