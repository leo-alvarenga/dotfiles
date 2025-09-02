Theme Contract for Waybar
========================

Files:
- style.css            -> Theme-agnostic Waybar CSS (imports theme.current.css)
- theme.current.css    -> One-line indirection to the active theme file
- rose_pine.css        -> Theme implementing the contract
- gruvbox_dark.css     -> Theme implementing the contract
- catpuccin_mocha.css  -> Theme implementing the contract

Contract variables every theme must provide:
- Backgrounds: bg-main, bg-alt, bg-hover, bg-hover-alt, bg-tooltip, bg-second, bg-third, sway-bg
- Foregrounds: fg-main, fg-subtle, fg-muted, fg-disabled, fg-on-accent
- Borders:     border-main, border-alt
- Accents:     accent-main, accent-secondary, accent-info, accent-success, accent-warning, accent-urgent
- Alias:       error (alias of accent-urgent for backwards compatibility)

Hot-swapping:
- Change the single line inside theme.current.css to import the theme you want, e.g.:
    @import "gruvbox_dark.css";
  or
    @import "rose_pine.css";

Optional:
- Your script can overwrite theme.current.css or symlink it to a theme file.
