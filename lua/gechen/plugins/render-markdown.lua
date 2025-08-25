local status, render_markdown = pcall(require, "render-markdown")
if not status then
  return
end

render_markdown.setup({
  -- Whether Markdown should be rendered by default or not
  enabled = true,
  -- Maximum file size (in MB) that this plugin will attempt to render
  -- Any file larger than this will skip rendering for performance
  max_file_size = 10.0,
  -- Capture groups that get pulled from markdown
  markdown_query = [[
    (atx_heading [
        (atx_h1_marker)
        (atx_h2_marker)
        (atx_h3_marker)
        (atx_h4_marker)
        (atx_h5_marker)
        (atx_h6_marker)
    ] @heading)

    (thematic_break) @dash

    (fenced_code_block) @code

    [
        (list_marker_plus)
        (list_marker_minus)
        (list_marker_star)
    ] @list_marker

    (task_list_marker_unchecked) @checkbox_unchecked
    (task_list_marker_checked) @checkbox_checked

    (block_quote (block_quote_marker) @quote_marker)
    (block_quote (paragraph (inline (block_continuation) @quote_marker)))

    (pipe_table) @table
    (pipe_table_header) @table_head
    (pipe_table_delimiter_row) @table_delim
    (pipe_table_row) @table_row
  ]],
  -- Capture groups that get pulled from inline markdown
  inline_query = [[
    (code_span) @code

    (shortcut_link) @callout

    [(emphasis) (strong_emphasis)] @quote
  ]],
  -- The level of logs to write to file: vim.fn.stdpath('state') .. '/render-markdown.log'
  -- Only intended to be used for plugin development / debugging
  log_level = 'error',
  -- Filetypes this plugin will run on
  file_types = { 'markdown' },
  -- Vim modes that will show a rendered view of the markdown file
  -- All other modes will be unaffected by this plugin
  render_modes = { 'n', 'c' },
  anti_conceal = {
    -- This enables hiding any added text on the line the cursor is on
    enabled = true,
  },
  heading = {
    -- Turn on / off heading icon & background rendering
    enabled = true,
    -- Turn on / off any sign column related rendering
    sign = true,
    -- Replaces '#+' of atx headings with icon
    -- The number of '#' in the heading determines the 'level'
    -- The 'level' is used to index into the array using a cycle
    -- The result is left padded with spaces to hide any additional '#'
    icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    -- Added to the sign column if enabled
    -- The 'level' is used to index into the array using a cycle
    signs = { '󰫎 ' },
    -- Width of the heading background:
    --  block: width of the heading text
    --  full: full width of the window
    width = 'full',
    -- The 'level' is used to index into the array using a clamp
    -- Highlight for the heading icon and extends through the entire line
    backgrounds = {
      'RenderMarkdownH1Bg',
      'RenderMarkdownH2Bg',
      'RenderMarkdownH3Bg',
      'RenderMarkdownH4Bg',
      'RenderMarkdownH5Bg',
      'RenderMarkdownH6Bg',
    },
    -- The 'level' is used to index into the array using a clamp
    -- Highlight for the heading and sign icons
    foregrounds = {
      'RenderMarkdownH1',
      'RenderMarkdownH2',
      'RenderMarkdownH3',
      'RenderMarkdownH4',
      'RenderMarkdownH5',
      'RenderMarkdownH6',
    },
  },
  code = {
    -- Turn on / off code block & inline code rendering
    enabled = true,
    -- Turn on / off any sign column related rendering
    sign = true,
    -- Determines how code blocks & inline code are rendered:
    --  none: disables all rendering
    --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
    --  language: adds language icon to sign column if enabled and icon + name above code blocks
    --  full: normal + language
    style = 'full',
    -- Amount of padding to add to the left of code blocks
    left_pad = 0,
    -- Amount of padding to add to the right of code blocks when width is 'block'
    right_pad = 0,
    -- Width of the code block background:
    --  block: width of the code block
    --  full: full width of the window
    width = 'full',
    -- Determins how the top / bottom of code block are rendered:
    --  thick: use the same highlight as the code body
    --  thin: when lines are empty overlay the above & below icons
    border = 'thin',
    -- Used above code blocks for thin border
    above = '▄',
    -- Used below code blocks for thin border
    below = '▀',
    -- Highlight for code blocks & inline code
    highlight = 'RenderMarkdownCode',
    highlight_inline = 'RenderMarkdownCodeInline',
  },
  dash = {
    -- Turn on / off thematic break rendering
    enabled = true,
    -- Replaces '---' of thematic break with icon
    icon = '─',
    -- Width of the generated line:
    --  <integer>: a hard coded width value
    --  full: full width of the window
    width = 'full',
    -- Highlight for the whole line generated from the icon
    highlight = 'RenderMarkdownDash',
  },
  bullet = {
    -- Turn on / off list bullet rendering
    enabled = true,
    -- Replaces '-'|'+'|'*' of unordered list with icon
    icons = { '●', '○', '◆', '◇' },
    -- Highlight for the bullet icon
    highlight = 'RenderMarkdownBullet',
  },
  -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'
  -- There are two special states for unchecked & checked defined in the markdown grammar
  checkbox = {
    -- Turn on / off checkbox state rendering
    enabled = true,
    unchecked = {
      -- Replaces '[ ]' of unchecked checkboxes with icon
      icon = '󰄱 ',
      -- Highlight for the unchecked icon
      highlight = 'RenderMarkdownUnchecked',
    },
    checked = {
      -- Replaces '[x]' of checked checkboxes with icon
      icon = '󰱒 ',
      -- Highlight for the checked icon
      highlight = 'RenderMarkdownChecked',
    },
    -- Define custom checkbox states, more involved as they are not part of the markdown grammar
    -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
    -- Can specify as many additional states as you like following the 'todo' pattern below
    --   The key in this case 'todo' is for display only & never used anywhere else
    --   The icon is used to replace the specified marker
    --   The highlight is used to color the specified marker
    --   The marker is what will be looked for and replaced with the icon
    custom = {
      todo = { icon = '󰥔 ', highlight = 'RenderMarkdownTodo', marker = '-' },
    },
  },
  quote = {
    -- Turn on / off block quote & emphasis rendering
    enabled = true,
    -- Replaces '>' of block quote with icon
    icon = '▋',
    -- Highlight for the quote icon
    highlight = 'RenderMarkdownQuote',
  },
  pipe_table = {
    -- Turn on / off pipe table rendering
    enabled = true,
    -- Determines how the table as a whole is rendered:
    --  none: disables all rendering
    --  normal: applies the 'cell' style rendering to each row of the table
    --  full: normal + a top & bottom line that fill out the table when lengths match
    style = 'full',
    -- Determines how individual cells of a table are rendered:
    --  overlay: writes completely over the table, removing conceal behavior and highlights
    --  raw: replaces only the '|' characters in each row, leaving the cells unmodified
    --  padded: raw + cells are padded with inline extmarks to make up for any concealed text
    cell = 'padded',
    -- Characters used to replace table border
    -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal
    -- stylua: ignore
    border = {
      '┌', '┬', '┐',
      '├', '┼', '┤',
      '└', '┴', '┘',
      '│', '─',
    },
    -- Highlight for table heading, delimiter, and the line above
    head = 'RenderMarkdownTableHead',
    -- Highlight for everything else, main table rows and the line below
    row = 'RenderMarkdownTableRow',
    -- Highlight for inline code when the cell does not contain a code block
    filler = 'RenderMarkdownTableFill',
  },
  -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'
  -- Can specify as many additional values as you like following the pattern from any below, such as 'note'
  --   The key in this case 'note' is for display only & never used anywhere else
  --   The icon is substituted for the text in the 'raw' field
  --   The highlight is used to color the text in the 'raw' field
  --   The raw field is what will be looked for and replaced with the icon
  callout = {
    note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
    tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
    important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
    warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
    caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
    -- Obsidian: https://help.a.md/Editing+and+formatting/Callouts
    abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'RenderMarkdownInfo' },
    todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'RenderMarkdownInfo' },
    success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'RenderMarkdownSuccess' },
    question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'RenderMarkdownWarn' },
    failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'RenderMarkdownError' },
    danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'RenderMarkdownError' },
    bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'RenderMarkdownError' },
    example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'RenderMarkdownHint' },
    quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = 'RenderMarkdownQuote' },
  },
  link = {
    -- Turn on / off inline link icon rendering
    enabled = true,
    -- Inlined with 'image' elements
    image = '󰥶 ',
    -- Inlined with 'inline_link' elements
    hyperlink = '󰌹 ',
    -- Applies to the fallback inlined icon
    highlight = 'RenderMarkdownLink',
  },
  sign = {
    -- Turn on / off sign rendering
    enabled = true,
    -- More granular mechanism, disable signs within specific buftypes
    exclude = {
      buftypes = { 'nofile' },
    },
    -- Applies to background of sign text
    highlight = 'RenderMarkdownSign',
  },
})
