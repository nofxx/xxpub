class Analyzer
  
  stop_words = %w{the a by on for of are with just but and to the my I has some in}
 
  
  lines = File.readlines("apress/oliver.txt")
  texto = lines.join
 
  tline = lines.size
  tchar = texto.length
  tnschar = texto.gsub(/\s+/, '').length
  tword = texto.split.length
  tfrase = texto.split(/\.|\?|!/).length
  tpara = texto.split(/\n\n/).length
 
  puts tline, tchar, tnschar, tfrase, tpara, '----\n---'
  
  puts "Total linhas: #{tline} ,\nTotal Chars: #{tchar}"
  
  fporp = tfrase / tpara
  pporl = tword / tfrase
  
  puts fporp, pporl
  
  end