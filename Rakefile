# encoding:Shift_JIS

DUMP_DIR = Dir.pwd + '/.dumps'
DEST_DIR = 't:/back/repo-dumps'

REPOS = FileList['*'].select{|x| File.directory?(x)}
DUMPS = REPOS.map{|x| [DUMP_DIR,"/",x,".svn"].join}
RDIFF_BAKUP = 'D:/DATA/rdiff-backup.exe'

directory DUMP_DIR
directory DEST_DIR

task :default do
  puts REPOS.join(' ')
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



