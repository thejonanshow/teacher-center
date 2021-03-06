User.destroy_all
Task.destroy_all
Project.destroy_all
ProjectTask.destroy_all

t1 = Task.create(medium: "Twitter"      , stage: "Phase 1")
t2 = Task.create(medium: "Facebook"     , stage: "Phase 2")
t3 = Task.create(medium: "Mail"         , stage: "Phase 3")
t4 = Task.create(medium: "Email"        , stage: "Phase 3")
t5 = Task.create(medium: "PrintAndShare", stage: "Phase 3")

start_date = Date.today - 60
expiration_date = Date.today + 120

#sample data
user = User.create(email: "donor@livingsocial.com", password: "hungry")
# project = Project.create_by_project_url('http://www.donorschoose.org/project/help-my-students-get-comfortable-with-re/795593/')
project = Project.create(
        :user_id => user.id,
        :city => "Washington",
        :cost_to_complete_cents => 150000,
        :dc_id => 593,
        :dc_url => "http://www.donorschoose.org/project/help-my-students-get-comfortable-with-re/795593/",
        :description => " I don't tend to get lost in a book when I'm sitting upright at a desk. Neither do my students. They like to feel cozy and alone. I have noticed that they are most involved in ...",
        :expiration_date => expiration_date,
        :goal_cents => 200000,
        :image_url => "http://www.donorschoose.org/images/user/uploads/small/u1025292_sm.jpg?timestamp=1336438786252",
        :percent_funded => 25,
        :school => "Jefferson Davis Middle School",
        :stage => "initial",
        :state => "D.C.",
        :teacher_name => "Mr. Casimir",
        :title => "Help My Students Get Comfortable With Reading",
        :start_date => start_date
)

funded = 0
date = start_date
counter = 0
until date == Date.today
  counter == 0 ? increment = rand(10000) : increment = 0
  counter >= 10 ? counter = 0 : counter += rand(5)
  funded += increment
  project.donation_logs.create(date: date, amount_funded_cents:funded)
  date += 1
end

project.update_attributes({:cost_to_complete_cents => project.goal_cents - funded, :percent_funded  => ((funded.to_f/project.goal_cents.to_f)*100).to_i})

task_ids =  [t1.id,t2.id,t3.id,t4.id,t5.id]
15.times do
  project.project_tasks.create(task_id: task_ids.sample, clicks: 2 + rand(18), completed: true, completed_on: start_date + rand((Date.today - start_date)/5) * 5 )
end


