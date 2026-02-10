-- Unit tests for texnative_dcl.lua validate_config function

-- Set up package path to find our modules
package.path = package.path .. ";./tests/?.lua;./tests/mocks/?.lua;./_extensions/texnative/?.lua"

-- Load the pandoc mock first
local pandoc = require("mocks.pandoc")
_G.pandoc = pandoc
-- Don't set _G.quarto so the module returns M for testing

-- Load the DCL module
local dcl = require("texnative_dcl")

describe("dcl.validate_config", function()
  it("returns true for nil config (feature disabled)", function()
    local valid, err = dcl.validate_config(nil)
    assert.is_true(valid)
    assert.is_nil(err)
  end)

  it("returns true for config without level (feature disabled)", function()
    local config = {
      levels = {
        confidential = { txt = "CONFIDENTIAL" }
      }
    }
    local valid, err = dcl.validate_config(config)
    assert.is_true(valid)
    assert.is_nil(err)
  end)

  it("returns false when level is set but no levels defined", function()
    local config = {
      level = "confidential"
    }
    local valid, err = dcl.validate_config(config)
    assert.is_false(valid)
    assert.is_not_nil(err)
    assert.matches("no levels are defined", err)
  end)

  it("returns false when level is not found in levels", function()
    local config = {
      level = "secret",
      levels = {
        confidential = { txt = "CONFIDENTIAL" }
      }
    }
    local valid, err = dcl.validate_config(config)
    assert.is_false(valid)
    assert.is_not_nil(err)
    assert.matches("not found in defined levels", err)
  end)

  it("returns false when level config is missing txt", function()
    local config = {
      level = "confidential",
      levels = {
        confidential = {
          bgcolor = "#ff0000"
        }
      }
    }
    local valid, err = dcl.validate_config(config)
    assert.is_false(valid)
    assert.is_not_nil(err)
    assert.matches("txt is required", err)
  end)

  it("returns true for valid complete config", function()
    local config = {
      level = "confidential",
      levels = {
        confidential = {
          bgcolor = "#ff0000",
          txtcolor = "#000000",
          txt = "CONFIDENTIAL"
        }
      }
    }
    local valid, err = dcl.validate_config(config)
    assert.is_true(valid)
    assert.is_nil(err)
  end)

  it("returns true for valid config with multiple levels", function()
    local config = {
      level = "internal",
      levels = {
        confidential = { txt = "CONFIDENTIAL" },
        internal = { txt = "INTERNAL" },
        public = { txt = "PUBLIC" }
      }
    }
    local valid, err = dcl.validate_config(config)
    assert.is_true(valid)
    assert.is_nil(err)
  end)
end)
