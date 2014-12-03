require '../lib/scbi_fastq/multi_gz_reader'

 file=MultiGzReader.new(File.join(File.dirname(__FILE__),'minitest.fastq.gz'))

    loop do
      res=file.readline
      puts "LINE: #{res}"
      break if res.nil?
    end

    file.close
