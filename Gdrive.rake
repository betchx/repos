# encoding:Shift_JIS

DUMP_DIR = Dir.pwd + '/.dumps'
DEST_DIR = 'g:/repo-dumps'

REPOS = FileList['*'].select{|x|
  File.directory?(x)}.select{|x| File.directory?(x+'/db')}

DUMPS = REPOS.map{|x| [DUMP_DIR,"/",x,".svn"].join}
RDIFF_BAKUP = 'rdiff-backup.exe'

directory DUMP_DIR
directory DEST_DIR

desc 'svn-backup-dump.pyを使用して全レポジトリをバックアップ'
task :default => REPOS do

end

REPOS.each do |repo|
  dest = [DEST_DIR, "/", repo].join

  directory dest

  desc "Backup '#{repo}' to #{DEST_DIR}/#{repo}/ "
  task repo => dest do
    sh "python svn-backup-dumps.py -b -i #{repo} #{dest}"
    %w(hooks conf).each do |sub_dir|
      mt = FileList["#{repo}/#{sub_dir}/**"].map{|x| File.mtime(x)}.max
      prev = File.mtime(dest+'/hooks/rdiff-backup-data')
      puts "Latest modified time: #{mt}"
      puts "Last backup dir time: #{prev}"
      if mt > prev
        sh "#{RDIFF_BAKUP} #{repo}/#{sub_dir} #{dest}/#{sub_dir}"
      else
        puts "Skip backup of #{repo}/#{sub_dir} "
      end
    end
  end
end


desc '(非推奨)レポジトリのダンプを更新して，バックアップ'
task :backup => DUMPS do
  sh "#{RDIFF_BAKUP} --print-statistics #{DUMP_DIR} #{DEST_DIR}"
end

REPOS.each_with_index do |repo,i|
  svn = DUMPS[i]
  pos = repo.pathmap("#{Dir.pwd}/%p")
  file svn => [repo+'/db/current', DUMP_DIR] do
    sh "svnadmin dump --deltas #{pos} > #{svn}"
  end
end



