(slb-hack-mode haskell-mode-hook nil
  (setq haskell-indentation-layout-offset 4
        haskell-indentation-left-offset 4
        haskell-indentation-ifte-offset 4)
  (turn-on-haskell-indentation))
