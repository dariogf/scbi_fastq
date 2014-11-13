require File.dirname(__FILE__) + '/test_helper.rb'

fqr=FastqFile.new('./sanger.fastq.gz')

fqr.each do |n,f,q|
  puts n  
end
fqr.close