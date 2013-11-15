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
    sh "#{RDIFF_BAKUP} #{repo}/hooks #{dest}/hooks"
    sh "#{RDIFF_BAKUP} #{repo}/conf #{dest}/conf"
  end
end


desc 'レポジトリのダンプを更新して，バックアップ'
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



