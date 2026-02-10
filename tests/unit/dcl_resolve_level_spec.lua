-- Unit tests for texnative_dcl.lua resolve_level function

-- Set up package path to find our modules
package.path = package.path .. ";./tests/?.lua;./tests/mocks/?.lua;./_extensions/texnative/?.lua"

-- Load the pandoc mock first
local pandoc = require("mocks.pandoc")
_G.pandoc = pandoc
-- Don't set _G.quarto so the module returns M for testing

-- Load the DCL module
local dcl = require("texnative_dcl")

describe("dcl.resolve_level", function()
  local levels = {
    confidential = {
      bgcolor = "#ff0000",
      txtcolor = "#000000",
      txt = "CONFIDENTIAL"
    },
    internal = {
      bgcolor = "#ee7d2f",
      txtcolor = "#000000",
      txt = "INTERNAL"
    },
    public = {
      bgcolor = "#70ac45",
      txtcolor = "#000000",
      txt = "PUBLIC"
    }
  }

  it("resolves a valid level key", function()
    local result = dcl.resolve_level("confidential", levels)
    assert.is_not_nil(result)
    assert.are.equal("CONFIDENTIAL", result.txt)
    assert.are.equal("#ff0000", result.bgcolor)
  end)

  it("resolves another valid level key", function()
    local result = dcl.resolve_level("internal", levels)
    assert.is_not_nil(result)
    assert.are.equal("INTERNAL", result.txt)
  end)

  it("returns nil for unknown level", function()
    local result = dcl.resolve_level("secret", levels)
    assert.is_nil(result)
  end)

  it("returns nil when level is nil", function()
    local result = dcl.resolve_level(nil, levels)
    assert.is_nil(result)
  end)

  it("returns nil when levels map is nil", function()
    local result = dcl.resolve_level("confidential", nil)
    assert.is_nil(result)
  end)

  it("returns nil when both arguments are nil", function()
    local result = dcl.resolve_level(nil, nil)
    assert.is_nil(result)
  end)
end)
