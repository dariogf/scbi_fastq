= scbi_fastq

* http://www.scbi.uma.es/downloads

== DESCRIPTION:

scbi_fastq is a ruby gem to read/write FASTQ files (DNA/RNA sequences) with qualities in a variety of formats (Sanger, Solexa, Ilumina).


== FEATURES/PROBLEMS:

* Read FASTQ files in Sanger Solexa and Ilumina, making the appropriate quality values conversions
* Quality values can be automatically splitted
* Write FASTQ files in Sanger format
* Iteration over large files without extra memory usage
* Can read gzip files directly

== SYNOPSIS:

=== Reading a compressed FASTQ in gzip with iterator:

  require 'scbi_fastq'

  # open gzip file in sanger mode
  fqr=FastqFile.new('file1.fastq.gz')

  fqr.each do |name,seq_fasta,qual,comments|

    puts name
    puts seq_fasta
    puts qual
    puts comments
  end
 
  fqr.close


=== Reading a FASTQ with iterator:

  require 'scbi_fastq'

  # open file in sanger mode
  fqr=FastqFile.new('file1.fastq')


  fqr.each do |name,seq_fasta,qual,comments|

    puts name
    puts seq_fasta
    puts qual
    puts comments
  end
 
  fqr.close

=== Reading a FASTQ one sequence at a time:

  require 'scbi_fastq'

  # open file in sanger mode
  fqr=FastqFile.new('file1.fastq')

  
	begin
	
    # read one sequence
    name,seq_fasta,qual,comments=fqr.next_seq

    # name will be nil if there are not more sequences available
	  if !name.nil?
      puts name
      puts seq_fasta
      puts qual
      puts comments
    end
	end until name.nil?

  fqr.close


=== Writing a FASTQ:

  require 'scbi_fastq'

  # open new file
  f=FastqFile.new('file.fastq','w')

  # prepare sample data
  name = 'seq1'
  seq_fasta= 'acgtacgtacact'
  seq_qual= [40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40]

  # write sequence to disk  
  f.write_seq(name,seq_fasta,seq_qual,'comments')


  # close file
  f.close

== REQUIREMENTS:

* This is a standalone gem.

== INSTALL:

* gem install scbi_fastq

## Contributing

1. Fork it ( https://github.com/[my-github-username]/scbi_fastq/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

