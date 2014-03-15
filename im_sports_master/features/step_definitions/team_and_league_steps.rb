Given /the following teams exist/ do |teams_table|
  teams_table.hashes.each do |team|
    fake_team = false
    if team[:placeholder] == "true"
      fake_team = true
    end
    team.delete("placeholder")
    team[:placeholder] = fake_team
    current_team = Team.create!(team)
    Division.find_by_id(team[:division_id]).teams << current_team
  end
end

Given /the following leagues exist/ do |leagues_table|
  leagues_table.hashes.each do |league|
    League.create!(league)
  end
end

And /user with email "(.*)" has been invited to join "(.*)"$/ do |email, team_name|
  user = User.find_by_email(email)
  team = Team.find_by_name(team_name)
  invitation = Invitation.new('user' => user, 'team' => team)
  user.invitations << invitation
  team.invitations << invitation
end

And /user with email "(.*)" is a member of "(.*)"/ do |email, team_name|
  user = User.find_by_email(email)
  team = Team.find_by_name(team_name)
  if not user.teams.include? team
    user.teams << team
  end
end
  

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body =~ /#{e1}.*#{e2}/m, "not sorted correctly"
end

Then /I should not see "(.*)" before "(.*)"/ do |e1, e2|
  if (page.body =~ /#{e1}.*#{e2}/m)
    flunk "Saw #{e1} before #{e2}"
  end
end
