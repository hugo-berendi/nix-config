{...}: let
  stickTap = action: "tap-hold-press 0 200 (one-shot-press-pcancel 1000 (${action})) (${action})";
  mkConfig = {
    blueTrigger,
    redTrigger,
    chordDelay,
  }: ''
    ;; {{{ Source layout
    (defsrc
      grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
      caps a    s    d    f    g    h    j    k    l    ;    '    ret
      lsft z    x    c    v    b    n    m    ,    .    /    rsft
      lctl lmet ${redTrigger}           spc            ${blueTrigger}
    )
    ;; }}}
    ;; {{{ Layer & utility aliases
    (defalias
      red (layer-while-held red)
      blue (layer-while-held blue)
      purple (layer-while-held purple)

      em (unicode —)
    )
    ;; }}}
    ;; {{{ Chord aliases
    (defalias
      chq (chord mainchords q)
      chw (chord mainchords w)
      che (chord mainchords e)
      chr (chord mainchords r)
      cha (chord mainchords a)
      chs (chord mainchords s)
      chd (chord mainchords d)
      chf (chord mainchords f)
      chz (chord mainchords z)
      chx (chord mainchords x)
      chc (chord mainchords c)
      chg (chord mainchords g)
      chh (chord mainchords h)
      chi (chord mainchords i)
      chp (chord mainchords p)
      chj (chord mainchords j)
      chk (chord mainchords k)
      chl (chord mainchords l)
      ch: (chord mainchords :)
      chn (chord mainchords n)
    )
    ;; }}}

    (defchords mainchords ${toString chordDelay}
    ;; {{{ Single keys
      (q) q
      (w) w
      (e) e
      (r) r
      (a) a
      (s) s
      (d) d
      (f) f
      (z) z
      (x) x
      (c) c
      (g) g
      (h) h
      (i) i
      (p) p
      (j) j
      (k) k
      (l) l
      (:) ;
      (n) n
    ;; }}}
      ;; {{{ Left modifiers
      (a s    ) lalt
      (  s d  ) lsft
      (  s   f) lctl
      (  s d f) C-lsft
      (a s d  ) S-lalt
      (a s d f) C-S-lalt
      ;; }}}
      ;; {{{ Right modifiers
      (    l :) ralt
      (  k l  ) rsft
      (j   l  ) rctl
      (j k l  ) C-rsft
      (  k l :) S-ralt
      (j k l :) C-S-ralt
      ;; }}}
      ;; {{{ Special keys
      (d f) tab
      (e f) ret
      (q w) esc

      (g h) bspc
      (n l) rmet

      (j k) f10
      (c p) f11
      (j i) f12
      ;; }}}
      ;; {{{ Wm keybinds
      (n l k) M-p
      (n l q) M-1
      (n l w) M-2
      (n l e) M-3
      (n l r) M-4
      (n l a) M-5
      (n l s) M-6
      (n l d) M-7
      (n l f) M-8
      (n l z) M-9
      (n l x) M-0
      ;; }}}
    )

    ;; {{{ Qwerty
    (deflayer qwerty
      XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX
      XX   @chq @chw @che @chr t    y    u    @chi o    @chp XX   XX   XX
      XX   @cha @chs @chd @chf @chg @chh @chj @chk @chl @ch: XX   XX
      lsft @chz @chx @chc v    b    @chn m    ,    .    '    XX
      XX   lmet @red           spc           @blue
    )
    ;; }}}
    ;; {{{ Transparent template
    (deflayer template
      _    _    _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _              _              _
    )
    ;; }}}
    ;; {{{ Blue
    (deflayer blue
      _    _    _    _    _    _    _    _    _    _    _    _    _    _
      _    S-=  S-2  S-3  S-4  S-5  S--  S-7  S-8  grv S-grv _    _    _
      _    S-,  S-[  [    S-9  S-/  S-\  -    /    =    S-;  _    _
      _    S-.  S-]  ]    S-0  S-1  @em  S-6  _    _    S-'  _
      _    _    @purple        \              _
    )
    ;; }}}
    ;; {{{ Red
    (deflayer red
      _    _    _    _    _    _    _    _    _    _    _    _    _    _
      _    1    2    3    4    5    home pgdn pgup end  del  _    _    _
      _    6    7    8    9    0    left down up   rght _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _              _           @purple
    )
    ;; }}}
    ;; {{{ Purple
    (defalias
      ;; Press once to active caps lock for a word (revert after being idle
      ;; for 2s), or twice for real caps lock.
      cps (tap-dance 200 ((caps-word 2000) caps))
      udo (arbitrary-code 131) ;; undo
      cpy (arbitrary-code 133) ;; copy
      pst (arbitrary-code 135) ;; paste
      cut (arbitrary-code 137) ;; cut
    )

    (deflayer purple
      _    _    _    _    _    _    _    _    _    _    _    _    _    _
      _    f1   f2   f3   f4   f5   @cps @cpy next volu brup _    _    _
      _    f6   f7   f8   f9   f10  @udo @pst pp   vold brdn _    _
      _    f11  f12  _    _    _    _    @cut prev mute _    _
      _    _    _              _              _
    )
    ;; }}}
  '';
in {
  services.kanata = {
    enable = true;
    keyboards.amaterasuLaptop = {
      devices = ["/dev/input/by-path/platform-i8042-serio-0-event-kbd"];

      config = mkConfig {
        redTrigger = "lalt";
        blueTrigger = "ralt";
        chordDelay = 25;
      };
    };

    keyboards.keychronK6 = {
      devices = ["/dev/input/by-id/usb-Keychron_Keychron_K2-event-kbd"];

      config = mkConfig {
        redTrigger = "lalt";
        blueTrigger = "rctl";
        chordDelay = 30;
      };
    };
  };
}
