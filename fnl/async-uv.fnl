(local a (require :async))

(macro gen-uv []
  (fn get-callback-func []
    (with-open [f (io.open :./uv-callbacks.txt :r)]
      (icollect [names (f:lines)]
        ;; remove `uv.` prefix
        (string.sub names 4))))

  (accumulate [uv {} _ v (ipairs (get-callback-func))]
    (do
      (tset uv v `(a.wrap (. vim.loop ,v)))
      uv)))

(gen-uv)
