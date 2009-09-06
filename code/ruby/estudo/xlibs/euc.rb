

def euc_ext(a,b,c)

  r = b % a
  return (c/a) % (b/a) if r.zero?
  euc_ext(r,a,-c) * b + c / a % b
end

def run(int, p, q, e)
  #return unless opts.length > 4

  #p,q,e = opts

  n = p * q

  qq = (p - 1) * (q - 1)

  d = euc_ext(e, qq, 1)

  puts "END"
  puts "N = #{n} E #{e} qq #{qq} D #{d}"
end
