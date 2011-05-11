#
# Jasmine Playground
#
#
# expect(x).toEqual(y); compares objects or primitives x and y and passes if they are equivalent
# expect(x).toBe(y); compares objects or primitives x and y and passes if they are the same object
# expect(x).toMatch(pattern); compares x to string or regular expression pattern and passes if they match
# expect(x).toBeDefined(); passes if x is not undefined
# expect(x).toBeNull(); passes if x is null
# expect(x).toBeTruthy(); passes if x evaluates to true
# expect(x).toBeFalsy(); passes if x evaluates to false
# expect(x).toContain(y); passes if array or string x contains y
# expect(x).toBeLessThan(y); passes if x is less than y
# expect(x).toBeGreaterThan(y); passes if x is greater than y
# expect(fn).toThrow(e); passes if function fn throws exception e when executed
#
# expect(x).not.toBe......


Sweet = require('../lib/sweet')


describe "Sweet...", ->
  s = new Sweet(10)

  beforeEach ->
    s.lxvl = 10
    x = 20

  it "works", ->
    expect(2 + 2).toEqual(4)

  it "looks good", ->
    expect(s.calc(6, 2)).toEqual(4)

  it "can access internal functions", ->
    expect(s.hi("Fx")).toEqual("Hi Fx")

  it "works as module", ->
    expect(s.sweetness()).toEqual(10)