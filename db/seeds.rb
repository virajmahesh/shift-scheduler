File.open('db/seed data/skills').each do |skill|
  Skill.create description: skill
end

File.open('db/seed data/issues').each do |issue|
  Issue.create description: issue
end



