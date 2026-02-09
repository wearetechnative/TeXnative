--[[
  texnative-dcl.lua - Data Classification Label Processor

  This Lua filter resolves the data_classification_label level lookup
  before LaTeX template rendering. It reads the 'level' selector, looks
  up the corresponding level configuration from 'levels', and flattens
  the resolved values into top-level metadata fields for LaTeX consumption.
]]

local M = {}

--- Strip the '#' prefix from a hex color string
-- @param hex string: A hex color like "#ff0000" or "ff0000"
-- @return string: The hex color without the '#' prefix
function M.strip_hex_prefix(hex)
  if hex == nil then
    return nil
  end
  local s = pandoc.utils.stringify(hex)
  if s:sub(1, 1) == "#" then
    return s:sub(2)
  end
  return s
end

--- Resolve a level configuration from the levels map
-- @param level string: The level key to look up (e.g., "confidential")
-- @param levels table: The levels map from metadata
-- @return table|nil: The level configuration or nil if not found
function M.resolve_level(level, levels)
  if level == nil or levels == nil then
    return nil
  end
  local level_key = pandoc.utils.stringify(level)
  if levels[level_key] then
    return levels[level_key]
  end
  return nil
end

--- Validate the data classification label configuration
-- @param dcl table: The data_classification_label metadata table
-- @return boolean, string|nil: true if valid, false with error message if invalid
function M.validate_config(dcl)
  if dcl == nil then
    return true, nil  -- No config is valid (feature disabled)
  end

  local level = dcl.level
  if level == nil then
    return true, nil  -- No level selected, feature disabled
  end

  local levels = dcl.levels
  if levels == nil then
    return false, "data_classification_label.level is set but no levels are defined"
  end

  local level_key = pandoc.utils.stringify(level)
  if levels[level_key] == nil then
    return false, "data_classification_label.level '" .. level_key .. "' not found in defined levels"
  end

  local level_config = levels[level_key]
  if level_config.txt == nil then
    return false, "data_classification_label.levels." .. level_key .. ".txt is required"
  end

  return true, nil
end

--- Generate LaTeX code for the data classification label
-- @param config table: Resolved configuration with all values
-- @return string: LaTeX code for the DCL
function M.generate_latex(config)
  local latex = [[
%% Data Classification Label
\usepackage{tikz}
\usepackage{eso-pic}

%% Define DCL colors
\definecolor{dclbgcolor}{HTML}{]] .. config.bgcolor .. [[}
\definecolor{dcltxtcolor}{HTML}{]] .. config.txtcolor .. [[}

%% DCL label command
\newcommand{\dataclassificationlabel}{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[
      fill=dclbgcolor,
      text=dcltxtcolor,
      rounded corners=]] .. config.border_radius .. [[,
      minimum width=]] .. config.width .. [[,
      minimum height=]] .. config.height .. [[,
      anchor=north west,
      font=\]] .. config.txtsize .. [[
    ] at ([xshift=]] .. config.left .. [[, yshift=-]] .. config.top .. [[]current page.north west)
    {]] .. config.txt .. [[};
  \end{tikzpicture}%
}

%% Add DCL to every page
\AddToShipoutPictureBG{\dataclassificationlabel}
]]
  return latex
end

--- Process metadata to resolve DCL configuration
-- Generates LaTeX code and injects it into header-includes
function Meta(meta)
  local dcl = meta.data_classification_label
  if dcl == nil then
    return meta
  end

  -- Validate configuration
  local valid, err = M.validate_config(dcl)
  if not valid then
    quarto.log.warning(err)
    return meta
  end

  -- Check if level is selected
  if dcl.level == nil then
    return meta
  end

  -- Resolve the level configuration
  local level_config = M.resolve_level(dcl.level, dcl.levels)
  if level_config == nil then
    return meta
  end

  -- Build resolved configuration
  local config = {
    txt = pandoc.utils.stringify(level_config.txt),
    bgcolor = M.strip_hex_prefix(level_config.bgcolor),
    txtcolor = M.strip_hex_prefix(level_config.txtcolor),
    width = pandoc.utils.stringify(dcl.width or "40mm"),
    height = pandoc.utils.stringify(dcl.height or "10mm"),
    top = pandoc.utils.stringify(dcl.top or "20mm"),
    left = pandoc.utils.stringify(dcl.left or "20mm"),
    txtsize = pandoc.utils.stringify(dcl.txtsize or "small"),
    border_radius = pandoc.utils.stringify(dcl["border-radius"] or "2pt")
  }

  -- Generate LaTeX code
  local latex_code = M.generate_latex(config)

  -- Inject into header-includes
  local header_includes = meta["header-includes"]
  if header_includes == nil then
    header_includes = pandoc.MetaList({})
  elseif pandoc.utils.type(header_includes) ~= "List" then
    header_includes = pandoc.MetaList({header_includes})
  end

  -- Add our LaTeX code as a RawBlock
  header_includes:insert(pandoc.MetaBlocks({pandoc.RawBlock("latex", latex_code)}))
  meta["header-includes"] = header_includes

  return meta
end

-- Export for testing
M.Meta = Meta

-- When running as Quarto filter, return filter list
-- When required as module (for testing), return M
if quarto then
  return { { Meta = Meta } }
else
  return M
end
