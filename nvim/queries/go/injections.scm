; extends

; Raw strings (backticks) that start with a SQL keyword.
; Neovim compiles #match? as a very-magic (\v) vim regex.
((raw_string_literal
  (raw_string_literal_content) @injection.content)
  (#match? @injection.content "\\c^\\_s*(select|insert|update|delete|replace|with|create|alter|drop)>")
  (#set! injection.language "sql"))

; Explicit tag for anything else, e.g. db.Exec(/* sql */ "...")
((comment) @_comment
  .
  [
    (raw_string_literal
      (raw_string_literal_content) @injection.content)
    (interpreted_string_literal
      (interpreted_string_literal_content) @injection.content)
  ]
  (#eq? @_comment "/* sql */")
  (#set! injection.language "sql"))

; Same tag on assignments, e.g. q := /* sql */ "..."
((comment) @_comment
  .
  (expression_list
    .
    [
      (raw_string_literal
        (raw_string_literal_content) @injection.content)
      (interpreted_string_literal
        (interpreted_string_literal_content) @injection.content)
    ])
  (#eq? @_comment "/* sql */")
  (#set! injection.language "sql"))
