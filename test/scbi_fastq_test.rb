require File.dirname(__FILE__) + '/test_helper.rb'

class TestScbiFastq < Test::Unit::TestCase

  def setup
    @test_file='/tmp/sanger.fastq';
    @test_file_gz='/tmp/sanger.fastq.gz';


    @seq_fasta='ACTG'
    @seq_qual=[31]
    @seq_name='SEQ'

  end

  def test_gz_sanger

    fqr=FastqFile.new(File.join(File.dirname(__FILE__),'sanger2.fastq.gz'))

    i=1

    fqr.each do |n,s,q|

      assert_equal(@seq_name+i.to_s,n)
      assert_equal(@seq_fasta*i,s)
      assert_equal((@seq_qual*i*@seq_fasta.length),q)

      i+=1
    end

    fqr.close


  end


  def test_mini_multi_gz_reader

    file=MultiGzReader.new(File.join(File.dirname(__FILE__),'minitest.fastq.gz'))
    
    i=0

    loop do
      res=file.readline
      #puts "LINE: #{res}"
      break if res.nil?
      i=i+1
    end

    file.close

    assert_equal(i,28)

  end

  def test_mini_multi_gz_reader_EOF_while

    # test a file with multiple gz streams

    fqr=FastqFile.new(File.join(File.dirname(__FILE__),'minitest.fastq.gz'))
    
    i=0

    fqr.each do |n,s,q|
      if !n.nil?
        i+=1
      end
    end

    fqr.close

    assert_equal(7,i)

  end
  
  def fill_file(n,offset=33)
    f=FastqFile.new(@test_file,'w')

    n.times do |c|
      i = c+1

      name = "#{@seq_name+i.to_s}"
      f.write_seq(name,@seq_fasta*i,(@seq_qual*i*@seq_fasta.length),'comments')
      # f.puts('@'+name)
      # f.puts(@seq_fasta*i)
      # f.puts('+'+name)
      # f.puts((@seq_qual*i*@seq_fasta.length).map{|e| (e+offset).chr}.join)
    end

    f.close
  end

  def fill_file_no_qual(n,offset=33)
    f=FastqFile.new(@test_file,'w')

    n.times do |c|
      i = c+1

      name = "#{@seq_name+i.to_s}"
      f.write_seq(name,@seq_fasta*i,'','comments')
      # f.puts('@'+name)
      # f.puts(@seq_fasta*i)
      # f.puts('+'+name)
      # f.puts((@seq_qual*i*@seq_fasta.length).map{|e| (e+offset).chr}.join)
    end

    f.close
  end


  def test_each

    # make new file and fill with data
    fill_file(100)


    fqr=FastqFile.new(@test_file)

    i=1

    fqr.each do |n,s,q|

      assert_equal(@seq_name+i.to_s,n)
      assert_equal(@seq_fasta*i,s)
      assert_equal((@seq_qual*i*@seq_fasta.length),q)

      i+=1
    end

    fqr.close
  end

  def test_each_comments

    # make new file and fill with data
    fill_file(100)


    fqr=FastqFile.new(@test_file)

    i=1

    fqr.each do |n,s,q,c|

      assert_equal(@seq_name+i.to_s,n)
      assert_equal(@seq_fasta*i,s)
      assert_equal((@seq_qual*i*@seq_fasta.length),q)
      assert_equal('comments',c)

      i+=1
    end

    fqr.close
  end

  def test_next_seq_comments

    # make new file and fill with data
    fill_file(100)


    fqr=FastqFile.new(@test_file)

    i=1

    begin
      n,s,q,c = fqr.next_seq

      if !n.nil?
        assert_equal(@seq_name+i.to_s,n)
        assert_equal(@seq_fasta*i,s)
        assert_equal((@seq_qual*i*@seq_fasta.length),q)
        assert_equal('comments',c)

        i+=1
      end
    end until n.nil?

    fqr.close
  end

  def test_to_fastq
    puts FastqFile.to_fastq(@seq_name,@seq_fasta*10,'','')

  end

  def test_each_no_qual

    # make new file and fill with data
    fill_file_no_qual(100)


    fqr=FastqFile.new(@test_file,'r',:sanger, false,false)

    i=1

    fqr.each do |n,s,q|
      # puts n,s,q
      assert_equal(@seq_name+i.to_s,n)
      assert_equal(@seq_fasta*i,s)
      # assert_equal((@seq_qual*i*@seq_fasta.length),q)

      i+=1
    end

    fqr.close
  end


  def fill_file_gz(n,offset=33)
    f=FastqFile.new(@test_file_gz,'w.gz')
    puts "FILE GZ"
    n.times do |c|
      i = c+1

      name = "#{@seq_name+i.to_s}"
      f.write_seq(name,@seq_fasta*i,(@seq_qual*i*@seq_fasta.length),'comments')
      # f.puts('@'+name)
      # f.puts(@seq_fasta*i)
      # f.puts('+'+name)
      # f.puts((@seq_qual*i*@seq_fasta.length).map{|e| (e+offset).chr}.join)
    end

    f.close
  end

  def test_each_gz
    # make new file and fill with data
    fill_file_gz(100)


    fqr=FastqFile.new(@test_file_gz)

    i=1

    fqr.each do |n,s,q|

      assert_equal(@seq_name+i.to_s,n)
      assert_equal(@seq_fasta*i,s)
      assert_equal((@seq_qual*i*@seq_fasta.length),q)

      i+=1
    end
    assert_equal(i,101)

    fqr.close
  end


  # def test_open_file
  #   fill_file(100)
  #   fq=FastqFile.new('test/sanger.fastq')
  #
  #   fq.each do |n,f,q|
  #      puts n,f,q
  #      puts fq.num_seqs
  #   end
  #
  #   fq.close
  #
  # end
end
