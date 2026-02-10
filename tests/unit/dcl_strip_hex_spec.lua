-- Unit tests for texnative_dcl.lua strip_hex_prefix function

-- Set up package path to find our modules
package.path = package.path .. ";./tests/?.lua;./tests/mocks/?.lua;./_extensions/texnative/?.lua"

-- Load the pandoc mock first
local pandoc = require("mocks.pandoc")
_G.pandoc = pandoc
-- Don't set _G.quarto so the module returns M for testing

-- Load the DCL module
local dcl = require("texnative_dcl")

describe("dcl.strip_hex_prefix", function()
  it("strips # prefix from hex color", function()
    local result = dcl.strip_hex_prefix("#ff0000")
    assert.are.equal("ff0000", result)
  end)

  it("returns unchanged if no # prefix", function()
    local result = dcl.strip_hex_prefix("ff0000")
    assert.are.equal("ff0000", result)
  end)

  it("handles uppercase hex colors", function()
    local result = dcl.strip_hex_prefix("#FF0000")
    assert.are.equal("FF0000", result)
  end)

  it("handles mixed case hex colors", function()
    local result = dcl.strip_hex_prefix("#Ff00aB")
    assert.are.equal("Ff00aB", result)
  end)

  it("returns nil for nil input", function()
    local result = dcl.strip_hex_prefix(nil)
    assert.is_nil(result)
  end)

  it("handles short hex colors with prefix", function()
    local result = dcl.strip_hex_prefix("#abc")
    assert.are.equal("abc", result)
  end)

  it("handles empty string", function()
    local result = dcl.strip_hex_prefix("")
    assert.are.equal("", result)
  end)

  it("handles string with only #", function()
    local result = dcl.strip_hex_prefix("#")
    assert.are.equal("", result)
  end)
end)
