" Dubs Vim guioptions setting, but mostly just a long comment.
" Author: Landon Bouma (landonb &#x40; retrosoft &#x2E; com)
" Online: https://github.com/landonb/dubs_appearance
" License: https://creativecommons.org/publicdomain/zero/1.0/

if exists("g:loaded_guioptions_galore") || &cp
  finish
endif
let g:loaded_guioptions_galore = 1

" *** Configure the &guioptions setting.
"
" The default guioptions depend on the platform:
"
"   'aegimrLtT' (GTK)
"   'egmrLtT'   (Windows)
"
" These are the default flag options (* indicates GTK-only):
"
"   * 'a' “Autoselect”: something about what's selected being automatically
"         added to the clipboard, or maybe I read the help wrong, because
"         I tested with and without this setting, and I could not figure
"         out how it works. So we'll exclude this option, I don't think
"         we're missing anything.
"           To test again: set guioptions+=a
"     'e' “Add tab pages when indicated with 'showtabline'.” Dubs Vim does
"         not reference 'showtabline', except now in this comment, and it's
"         always had this option enabled, so leaving enabled, though I'm
"         not sure how it operates/what it does.
"           To test without: set guioptions-=e
"     'g' “Grey menu items: Make menu items that are not active grey.” We can
"         leave this enabled, in case the user wants shows the menu bar again.
"   * 'i' “Use a Vim icon.” I.e., what you see when you Alt-Tab, and what you
"         see in the MATE (or Gnome, whatever) Window List Panel (e.g., the
"         MATE Window List application is /usr/lib/mate-panel/wnck-applet).
"         - 2020-03-01: This has never been enabled in Dubs Vim (not since 2009),
"           but I did not leave myself a note why, which leaves me w/ 2 guesses:
"           (a) I forgot about this setting when I migrated from developing on
"           Windows to Linux sometime last mid-decade (though you'd think my
"           10-year-younger self would have noticed and cared that guioptions
"           is different depending on the platform, and would have written an
"           if-else block to set guioptions accordingly; but also maybe I was
"           more naive back then); or, perhaps
"           (b) I deliberately disabled this option (but did not comment why)
"           because I find the Vim icon ugly and dated. But if that's the case:
"           MAYBE/2020-03-01: Customize the Vim icon (to your liking). (Now that
"           I figured out how to get gvim to set an icon for the window manager,
"           can I easily edit and customize that icon? To personalize it to my
"           taste?)
"     'm' “Menu bar is present.” As mentioned in later comment section, hiding.
"     'r' “Right-hand scrollbar is always present.”. A feature that you'd at
"         first think you want -- because all graphical text editors would use
"         one, right? -- and that Dubs Vim has had enabled since its humble
"         roots in 2009. But now it's 2020, and scrollbars are so dated. Who
"         uses them anymore? Maybe as a visual reference to gauge how big a
"         file is, or maybe to see where the cursor is relative to the top
"         or bottom of a file; but both of those informations can be gleaned
"         (and more precisely, too), from the status footer (aka mescaline)
"         (well, so long as the file path is not so long that it clips those
"         details from the status line). As for scrolling, I either use keys
"         (Ctrl-Up/-Down, Page Up/Down, gg, G, Ctrl-Home, etc.) or the mouse
"         wheel; I cannot recall the last time I grabbed a scrollbar elevator.
"     'L' “Left-hand scrollbar is present when ... a vertically split window.”
"         For same reasons as right-hand scrollbar, hiding, because I only used
"         the scrollbar as a visual cue to tell the relative line position and
"         file length, but that information is included (and more precisely, too)
"         in the dubs_mescaline status line below each window.
"     't' “Include tearoff menu items.” A 'cute' feature that lets you float
"         menus and submenus, but also which seems completely useless. I cannot
"         think of a good use case. Maybe if I wanted to repeat the same command
"         over and over again using my mouse, or something? In any case, leaving
"         enabled, because it doesn't get in the way, and it's always been part
"         of the team.
"     'T' “Include Toolbar.” That row of useless clickable icons wired to a few
"         simple commands. Dubs Vim has hidden the toolbar since Dubs Vim's
"         inception back in 2009, and Dubs Vim plans to continue to shun the
"         Vim Toolbar in perpetuity.
"
" Dubs Vim historically (for the past 10 years, since 2009) has hidden the
" toolbar, but it has not hidden the menu bar, noting: "Get rid of (hide) the
" silly, space-wasting Vim toolbar (but not menu bar)."
" - 2020-03-01: But I've grown since then. And now I want to hide the menu bar:
"   - I'd rather have the additional line space (1 more row in my editor!).
"   - I'd appreciate less clutter in my view, especially when Vim is fullscreen.
"   - I never use the menu for discovery (to see what commands are available),
"     and I never interact with the menu using the mouse; but I do use the
"     alt-key menu combinations, which is not because I'm lazy and did not
"     bother learning the equivalent Vim builtins, but it was because the
"     alt-key menu hooks work in insert mode, and the Vim builtins do not.
"     (E.g., Vim's <Ctrl-w>q command closes a window from normal mode, but
"     <Ctrl-w> has a different meaning in insert mode. So I would always use
"     the menu bar's <Alt-w>c, which works from both modes!)
"   - To keep the same user experience, just without the menu bar,
"     we'll recreate the menu bar key mappings that we want to keep.
"     - We can use Vim's normal `map` mechanism to recreate the mappings,
"       essentially duplicating the `amenu` commands we want to recreate
"       (but using a normal-looking key binding like <M-w>c, rather than
"       the cute title-and-shortcut-in-one syntax like `&Window.&Close`).
"
" If you run Vim with any or all of these options enabled, you can easily
" disable any one of them:
"   :set guioptions-=m  " remove menu bar
"   :set guioptions-=T  " remove toolbar
"   :set guioptions-=r  " remove right-hand scroll bar
"   :set guioptions-=L  " remove left-hand scroll bar
" Or if you run Dubs Vim with any of these options disabled, you can easily
" enable any one/each of them:
"   :set guioptions+=m  " show menu bar
"   :set guioptions+=T  " show toolbar
"   :set guioptions+=r  " show right-hand scroll bar
"   :set guioptions+=L  " show left-hand scroll bar (when vertical split present)
"
" - HINT/2020-03-01: To be extra clear, the menu bar is still configured as
"   it's always been (that code still exists below), but now we're hiding it
"   on startup. If you want to see the menu bar at any time, simply run:
"
"         set guioptions+=m  " See what you're missing.
"
function! s:GuiSetGuioptions()
  if !has("gui_running") | return | endif
  " See long comments above.
  " - These options differ from the default/builtins by hiding
  "   these elements: menubar; toolbar; always right scrollbar;
  "   sometimes left scrollbar.
  " - 2020-03-01: These options also exclude 'a' (Autoselect)
  "   which I read about today but could not see have any effect
  "   on my machine, and since I did not ever have 'a' as an option
  "   in Dubs Vim, I'm not adding it now (just adding this comment).
  set guioptions=egit
endfunction

call s:GuiSetGuioptions()

