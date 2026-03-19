-- Unit tests for texnative_dcl.lua Meta function (dcl_cover_text)

-- Set up package path to find our modules
package.path = package.path .. ";./tests/?.lua;./tests/mocks/?.lua;./_extensions/texnative/?.lua"

-- Load the pandoc mock first
local pandoc = require("mocks.pandoc")

-- Add MetaList mock (needed by Meta function)
function pandoc.MetaList(items)
  local list = {}
  if items then
    for _, item in ipairs(items) do
      table.insert(list, item)
    end
  end
  list.insert = function(self, item) table.insert(self, item) end
  return list
end

-- Add MetaBlocks mock
function pandoc.MetaBlocks(blocks)
  return { t = "MetaBlocks", content = blocks }
end

-- Add pandoc.utils.type mock
function pandoc.utils.type(val)
  if type(val) == "table" then
    if val.t then return val.t end
    -- Check if it looks like a list
    if #val > 0 or getmetatable(val) == pandoc.List then
      return "List"
    end
    return "table"
  end
  return type(val)
end

_G.pandoc = pandoc

-- Mock quarto for the Meta function
_G.quarto = { log = { warning = function() end } }

-- Load the DCL module (with quarto set, it returns filter list)
-- We need to unset quarto to get M back
_G.quarto = nil
local dcl = require("texnative_dcl")
-- Re-set quarto for Meta calls
_G.quarto = { log = { warning = function() end } }

describe("dcl.Meta sets dcl_cover_text", function()

  it("sets dcl_cover_text when level is configured", function()
    local meta = {
      data_classification_label = {
        level = "confidential",
        levels = {
          confidential = {
            bgcolor = "#ff0000",
            txtcolor = "#000000",
            txt = "CONFIDENTIAL"
          }
        }
      }
    }

    local result = dcl.Meta(meta)
    assert.are.equal("CONFIDENTIAL", result.dcl_cover_text)
  end)

  it("sets dcl_cover_text to correct level text", function()
    local meta = {
      data_classification_label = {
        level = "internal",
        levels = {
          confidential = {
            bgcolor = "#ff0000",
            txtcolor = "#000000",
            txt = "CONFIDENTIAL"
          },
          internal = {
            bgcolor = "#ee7d2f",
            txtcolor = "#000000",
            txt = "INTERNAL"
          }
        }
      }
    }

    local result = dcl.Meta(meta)
    assert.are.equal("INTERNAL", result.dcl_cover_text)
  end)

  it("does NOT set dcl_cover_text when level is not configured", function()
    local meta = {
      data_classification_label = {
        levels = {
          confidential = {
            bgcolor = "#ff0000",
            txtcolor = "#000000",
            txt = "CONFIDENTIAL"
          }
        }
      }
    }

    local result = dcl.Meta(meta)
    assert.is_nil(result.dcl_cover_text)
  end)

  it("does NOT set dcl_cover_text when dcl is absent", function()
    local meta = {}

    local result = dcl.Meta(meta)
    assert.is_nil(result.dcl_cover_text)
  end)
end)
