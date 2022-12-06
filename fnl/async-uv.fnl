(local a (require :async))

(macro gen-uv []
  (fn get-cb-set []
    (with-open [f (io.open :./uv-callbacks.txt :r)]
      (accumulate [cb-set {} name (f:lines)]
        (do
          ;; remove `uv.` prefix
          (tset cb-set (string.sub name 4) true)
          cb-set))))

  (let [cb-set (get-cb-set)]
    (accumulate [uv {} k _ (pairs vim.loop)]
      (do
        (if (. cb-set k)
            (tset uv k `(a.wrap (. vim.loop ,k)))
            (tset uv k `(. vim.loop ,k)))
        uv))))

(gen-uv)
