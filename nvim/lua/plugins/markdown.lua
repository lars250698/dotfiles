return {
  {
    "obsidian-nvim/obsidian.nvim",
    -- "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "/Users/lars.eppinger/Library/Mobile Documents/iCloud~md~obsidian/Documents/personal",
        },
        {
          name = "work",
          path = "/Users/lars.eppinger/Library/Mobile Documents/iCloud~md~obsidian/Documents/work",
        },
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      disable_frontmatter = true,
      new_notes_location = "current_dir",
      note_id_func = function(title)
        if title ~= nil then
          return title
        else
          return "Untitled"
        end
      end,
      follow_url_func = function(url)
        vim.ui.open(url)
      end,
    },
    keys = {
      {
        "<leader>o",
        group = "+obsidian",
        desc = "Obsidian",
        ft = "markdown",
      },
      {
        "<leader>on",
        function()
          vim.cmd("ObsidianNew")
        end,
        desc = "New Note",
        ft = "markdown",
      },
      {
        "<leader>om",
        function()
          local meetingName = vim.fn.input("Meeting name: ")
          local date = os.date("%Y-%m-%d-%H-%M")
          local title = date .. " Meeting " .. meetingName
          local dir = "./01 - Projects/00 - Meetings/"
          local title_with_dir = dir .. title
          vim.cmd(string.format("ObsidianNew %s", title_with_dir))
          vim.cmd("ObsidianTemplate Meeting Notes")
        end,
        desc = "New Meeting Note",
        ft = "markdown",
      },
      {
        "<leader>ot",
        function()
          vim.cmd("ObsidianTemplate")
        end,
        desc = "Apply Template",
        ft = "markdown",
      },
      {
        "<leader>ob",
        function()
          vim.cmd("ObsidianBacklink")
        end,
        desc = "Backlinks",
        ft = "markdown",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        -- Turn on / off heading icon & background rendering.
        enabled = true,
        -- Additional modes to render headings.
        render_modes = false,
        -- Turn on / off any sign column related rendering.
        sign = true,
        -- Replaces '#+' of 'atx_h._marker'.
        -- Output is evaluated depending on the type.
        -- | function | `value(context)`              |
        -- | string[] | `cycle(value, context.level)` |
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- Determines how icons fill the available space.
        -- | right   | '#'s are concealed and icon is appended to right side                          |
        -- | inline  | '#'s are concealed and icon is inlined on left side                            |
        -- | overlay | icon is left padded with spaces and inserted on left hiding any additional '#' |
        position = "overlay",
        -- Added to the sign column if enabled.
        -- Output is evaluated by `cycle(value, context.level)`.
        signs = { "󰫎 " },
        -- Width of the heading background.
        -- | block | width of the heading text |
        -- | full  | full width of the window  |
        -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
        width = "full",
        -- Amount of margin to add to the left of headings.
        -- Margin available space is computed after accounting for padding.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
        left_margin = 0,
        -- Amount of padding to add to the left of headings.
        -- Output is evaluated using the same logic as 'left_margin'.
        left_pad = 0,
        -- Amount of padding to add to the right of headings when width is 'block'.
        -- Output is evaluated using the same logic as 'left_margin'.
        right_pad = 0,
        -- Minimum width to use for headings when width is 'block'.
        -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
        min_width = 0,
        -- Determines if a border is added above and below headings.
        -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
        border = false,
        -- Always use virtual lines for heading borders instead of attempting to use empty lines.
        border_virtual = false,
        -- Highlight the start of the border using the foreground highlight.
        border_prefix = false,
        -- Used above heading for border.
        above = "▄",
        -- Used below heading for border.
        below = "▀",
        -- Highlight for the heading icon and extends through the entire line.
        -- Output is evaluated by `clamp(value, context.level)`.
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        -- Highlight for the heading and sign icons.
        -- Output is evaluated using the same logic as 'backgrounds'.
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
        -- Define custom heading patterns which allow you to override various properties based on
        -- the contents of a heading.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | pattern    | matched against the heading text @see :h lua-pattern |
        -- | icon       | optional override for the icon                       |
        -- | background | optional override for the background                 |
        -- | foreground | optional override for the foreground                 |
        custom = {},
      },
      paragraph = {
        -- Turn on / off paragraph rendering.
        enabled = true,
        -- Additional modes to render paragraphs.
        render_modes = false,
        -- Amount of margin to add to the left of paragraphs.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        left_margin = 0,
        -- Minimum width to use for paragraphs.
        min_width = 0,
      },
      code = {
        -- Turn on / off code block & inline code rendering.
        enabled = true,
        -- Additional modes to render code blocks.
        render_modes = false,
        -- Turn on / off any sign column related rendering.
        sign = true,
        -- Determines how code blocks & inline code are rendered.
        -- | none     | disables all rendering                                                    |
        -- | normal   | highlight group to code blocks & inline code, adds padding to code blocks |
        -- | language | language icon to sign column if enabled and icon + name above code blocks |
        -- | full     | normal + language                                                         |
        style = "full",
        -- Determines where language icon is rendered.
        -- | right | right side of code block |
        -- | left  | left side of code block  |
        position = "left",
        -- Amount of padding to add around the language.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        language_pad = 0,
        -- Whether to include the language name next to the icon.
        language_name = true,
        -- A list of language names for which background highlighting will be disabled.
        -- Likely because that language has background highlights itself.
        -- Use a boolean to make behavior apply to all languages.
        -- Borders above & below blocks will continue to be rendered.
        disable_background = { "diff" },
        -- Width of the code block background.
        -- | block | width of the code block  |
        -- | full  | full width of the window |
        width = "full",
        -- Amount of margin to add to the left of code blocks.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        -- Margin available space is computed after accounting for padding.
        left_margin = 0,
        -- Amount of padding to add to the left of code blocks.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        left_pad = 0,
        -- Amount of padding to add to the right of code blocks when width is 'block'.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        right_pad = 0,
        -- Minimum width to use for code blocks when width is 'block'.
        min_width = 0,
        -- Determines how the top / bottom of code block are rendered.
        -- | none  | do not render a border                               |
        -- | thick | use the same highlight as the code body              |
        -- | thin  | when lines are empty overlay the above & below icons |
        border = "thin",
        -- Used above code blocks for thin border.
        above = "▄",
        -- Used below code blocks for thin border.
        below = "▀",
        -- Highlight for code blocks.
        highlight = "RenderMarkdownCode",
        -- Highlight for language, overrides icon provider value.
        highlight_language = nil,
        -- Padding to add to the left & right of inline code.
        inline_pad = 0,
        -- Highlight for inline code.
        highlight_inline = "RenderMarkdownCodeInline",
      },
      dash = {
        -- Turn on / off thematic break rendering.
        enabled = true,
        -- Additional modes to render dash.
        render_modes = false,
        -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'.
        -- The icon gets repeated across the window's width.
        icon = "─",
        -- Width of the generated line.
        -- | <number> | a hard coded width value |
        -- | full     | full width of the window |
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        width = "full",
        -- Amount of margin to add to the left of dash.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        left_margin = 0,
        -- Highlight for the whole line generated from the icon.
        highlight = "RenderMarkdownDash",
      },
      bullet = {
        -- Turn on / off list bullet rendering
        enabled = true,
        -- Additional modes to render list bullets
        render_modes = false,
        -- Replaces '-'|'+'|'*' of 'list_item'.
        -- If the item is a 'checkbox' a conceal is used to hide the bullet instead.
        -- Output is evaluated depending on the type.
        -- | function   | `value(context)`                                    |
        -- | string     | `value`                                             |
        -- | string[]   | `cycle(value, context.level)`                       |
        -- | string[][] | `clamp(cycle(value, context.level), context.index)` |
        icons = { "●", "○", "◆", "◇" },
        -- Replaces 'n.'|'n)' of 'list_item'.
        -- Output is evaluated using the same logic as 'icons'.
        ordered_icons = function(ctx)
          local value = vim.trim(ctx.value)
          local index = tonumber(value:sub(1, #value - 1))
          return string.format("%d.", index > 1 and index or ctx.index)
        end,
        -- Padding to add to the left of bullet point.
        -- Output is evaluated depending on the type.
        -- | function | `value(context)` |
        -- | integer  | `value`          |
        left_pad = 0,
        -- Padding to add to the right of bullet point.
        -- Output is evaluated using the same logic as 'left_pad'.
        right_pad = 0,
        -- Highlight for the bullet icon.
        -- Output is evaluated using the same logic as 'icons'.
        highlight = "RenderMarkdownBullet",
        -- Highlight for item associated with the bullet point.
        -- Output is evaluated using the same logic as 'icons'.
        scope_highlight = {},
      },
      checkbox = {
        -- Turn on / off checkbox state rendering.
        enabled = true,
        -- Additional modes to render checkboxes.
        render_modes = false,
        -- Determines how icons fill the available space.
        -- | inline  | underlying text is concealed resulting in a left aligned icon |
        -- | overlay | result is left padded with spaces to hide any additional text |
        position = "inline",
        unchecked = {
          -- Replaces '[ ]' of 'task_list_marker_unchecked'.
          icon = "󰄱 ",
          -- Highlight for the unchecked icon.
          highlight = "RenderMarkdownUnchecked",
          -- Highlight for item associated with unchecked checkbox.
          scope_highlight = nil,
        },
        checked = {
          -- Replaces '[x]' of 'task_list_marker_checked'.
          icon = "󰱒 ",
          -- Highlight for the checked icon.
          highlight = "RenderMarkdownChecked",
          -- Highlight for item associated with checked checkbox.
          scope_highlight = nil,
        },
        -- Define custom checkbox states, more involved, not part of the markdown grammar.
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw             | matched against the raw text of a 'shortcut_link'           |
        -- | rendered        | replaces the 'raw' value when rendering                     |
        -- | highlight       | highlight for the 'rendered' icon                           |
        -- | scope_highlight | optional highlight for item associated with custom checkbox |
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        },
      },
      quote = {
        -- Turn on / off block quote & callout rendering.
        enabled = true,
        -- Additional modes to render quotes.
        render_modes = false,
        -- Replaces '>' of 'block_quote'.
        icon = "▋",
        -- Whether to repeat icon on wrapped lines. Requires neovim >= 0.10. This will obscure text
        -- if incorrectly configured with :h 'showbreak', :h 'breakindent' and :h 'breakindentopt'.
        -- A combination of these that is likely to work follows.
        -- | showbreak      | '  ' (2 spaces)   |
        -- | breakindent    | true              |
        -- | breakindentopt | '' (empty string) |
        -- These are not validated by this plugin. If you want to avoid adding these to your main
        -- configuration then set them in win_options for this plugin.
        repeat_linebreak = false,
        -- Highlight for the quote icon.
        highlight = "RenderMarkdownQuote",
      },
      pipe_table = {
        -- Turn on / off pipe table rendering.
        enabled = true,
        -- Additional modes to render pipe tables.
        render_modes = false,
        -- Pre configured settings largely for setting table border easier.
        -- | heavy  | use thicker border characters     |
        -- | double | use double line border characters |
        -- | round  | use round border corners          |
        -- | none   | does nothing                      |
        preset = "none",
        -- Determines how the table as a whole is rendered.
        -- | none   | disables all rendering                                                  |
        -- | normal | applies the 'cell' style rendering to each row of the table             |
        -- | full   | normal + a top & bottom line that fill out the table when lengths match |
        style = "full",
        -- Determines how individual cells of a table are rendered.
        -- | overlay | writes completely over the table, removing conceal behavior and highlights |
        -- | raw     | replaces only the '|' characters in each row, leaving the cells unmodified |
        -- | padded  | raw + cells are padded to maximum visual width for each column             |
        -- | trimmed | padded except empty space is subtracted from visual width calculation      |
        cell = "padded",
        -- Amount of space to put between cell contents and border.
        padding = 1,
        -- Minimum column width to use for padded or trimmed cell.
        min_width = 0,
        -- Characters used to replace table border.
        -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
        -- stylua: ignore
        border = {
            '┌', '┬', '┐',
            '├', '┼', '┤',
            '└', '┴', '┘',
            '│', '─',
        },
        -- Gets placed in delimiter row for each column, position is based on alignment.
        alignment_indicator = "━",
        -- Highlight for table heading, delimiter, and the line above.
        head = "RenderMarkdownTableHead",
        -- Highlight for everything else, main table rows and the line below.
        row = "RenderMarkdownTableRow",
        -- Highlight for inline padding used to add back concealed space.
        filler = "RenderMarkdownTableFill",
      },
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
        -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
        abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
        summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
        tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
        info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
        todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
        hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
        success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
        check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
        done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
        question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
        help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
        faq = { raw = "[!FAQ]", rendered = "󰘥 Faq", highlight = "RenderMarkdownWarn" },
        attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
        failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
        fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
        missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
        danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
        error = { raw = "[!ERROR]", rendered = "󱐌 Error", highlight = "RenderMarkdownError" },
        bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
        example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
        quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
        cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
      },
      link = {
        -- Turn on / off inline link icon rendering.
        enabled = true,
        -- Additional modes to render links.
        render_modes = false,
        -- How to handle footnote links, start with a '^'.
        footnote = {
          -- Replace value with superscript equivalent.
          superscript = true,
          -- Added before link content when converting to superscript.
          prefix = "",
          -- Added after link content when converting to superscript.
          suffix = "",
        },
        -- Inlined with 'image' elements.
        image = "󰥶 ",
        -- Inlined with 'email_autolink' elements.
        email = "󰀓 ",
        -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
        hyperlink = "󰌹 ",
        -- Applies to the inlined icon as a fallback.
        highlight = "RenderMarkdownLink",
        -- Applies to WikiLink elements.
        wiki = {
          icon = "󱗖 ",
          body = function()
            return nil
          end,
          highlight = "RenderMarkdownWikiLink",
        },
        -- Define custom destination patterns so icons can quickly inform you of what a link
        -- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
        -- patterns match a link the one with the longer pattern is used.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | pattern   | matched against the destination text, @see :h lua-pattern       |
        -- | icon      | gets inlined before the link text                               |
        -- | highlight | optional highlight for 'icon', uses fallback highlight if empty |
        custom = {
          web = { pattern = "^http", icon = "󰖟 " },
          discord = { pattern = "discord%.com", icon = "󰙯 " },
          github = { pattern = "github%.com", icon = "󰊤 " },
          gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
          google = { pattern = "google%.com", icon = "󰊭 " },
          neovim = { pattern = "neovim%.io", icon = " " },
          reddit = { pattern = "reddit%.com", icon = "󰑍 " },
          stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
          wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
          youtube = { pattern = "youtube%.com", icon = "󰗃 " },
        },
      },
      sign = {
        -- Turn on / off sign rendering.
        enabled = true,
        -- Applies to background of sign text.
        highlight = "RenderMarkdownSign",
      },
      indent = {
        -- Turn on / off org-indent-mode.
        enabled = false,
        -- Additional modes to render indents.
        render_modes = false,
        -- Amount of additional padding added for each heading level.
        per_level = 2,
        -- Heading levels <= this value will not be indented.
        -- Use 0 to begin indenting from the very first level.
        skip_level = 1,
        -- Do not indent heading titles, only the body.
        skip_heading = false,
        -- Prefix added when indenting, one per level.
        icon = "▎",
        -- Applied to icon.
        highlight = "RenderMarkdownIndent",
      },
    },
  },
}
