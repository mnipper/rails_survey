namespace :project do
  task :copy, [:project_id] => [:environment] do |t, args|
    project = Project.find(args[:project_id].to_i)

    project_to = project.dup 
    project_to.name = "#{project.name} - COPY"
    project_to.save!

    project.instruments.each do |instrument|
      i = instrument.dup
      i.project_id = project_to.id
      i.save!

      instrument.rules.each do |rule|
        r = rule.dup
        r.instrument_id = i.id
        r.save!
      end

      instrument.translations.each do |translation|
        t = translation.dup
        t.instrument_id = i.id
        t.save!
      end

=begin
      instrument_version = instrument.version_by_version_number(instrument.current_version_number)
      iv = instrument_version.dup
      iv.instrument_id = i.id
      iv.save!
=end

      instrument.questions.each do |question|
        q = question.dup
        q.question_identifier = "#{question.question_identifier}_#{project_to.id}"
        q.instrument_id = i.id
        q.save!

        question.images.each do |image|
          im = image.dup
          im.question_id = q.id 
          im.save!
        end

        question.translations.each do |translation|
          t = translation.dup
          t.question_id = q.id
          t.save!
        end

        question.options.each do |option|
          o = option.dup
          o.next_question = "#{option.next_question}_#{project_to.id}"
          o.question_id = q.id
          o.save!

          option.skips.each do |skip|
            s = skip.dup
            s.question_identifier = "#{skip.question_identifier}_#{project_to.id}"
            s.option_id = o.id
            s.save!
          end

          option.translations.each do |translation|
            t = translation.dup
            t.option_id = o.id
            t.save!
          end
        end
      end

      instrument.sections.each do |section|
        s = section.dup
        s.start_question_identifier = "#{section.start_question_identifier}_#{project_to.id}"
        s.instrument_id = i.id
        s.save!

        section.translations.each do |translation|
          t = translation.dup
          t.section_id = s.id
          t.save!
        end
      end
    end
  end
end
