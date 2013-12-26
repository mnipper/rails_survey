namespace :db do
  desc "Create a lot of data in the database to test syncing performance"
  task muchdata: :environment do
    10.times do |i_n|
      i = Instrument.create!(title: "Instrument #{i_n}",
        language: Settings.languages.sample,
        alignment: "left"
      )
      p "Created #{i.title}"
      10000.times do |q_n|
        question_type = Settings.question_types.sample
        question = i.questions.create!(text: "Question #{q_n}",
          question_identifier: "#{i_n}_q_#{q_n}",
          question_type: Settings.question_types.sample
        )
        if Settings.question_with_options.include? question_type
          5.times do |o_n|
            question.options.create!(text: "Option #{o_n}") 
          end
        end
      end
    end
  end
end
