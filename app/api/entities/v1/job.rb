module API::Entities::V1
	class Job < API::Entities::V1::Base
		expose :id, documentation: { type: 'Integer', desc: 'Id of Job.' }
		expose :title, documentation: { type: 'String', desc: 'Title of Job.' }
		expose :province, documentation: { type: 'String', desc: 'Province of Job.' }
		expose :state, documentation: { type: 'String', desc: 'State of Job.' }
		expose :salary, documentation: { type: 'String', desc: 'Salary of Job.' }
		expose :salary_text, documentation: { type: 'String', desc: 'Salary of Job.' }
		expose :min_salary, documentation: { type: 'Integer', desc: 'Min Salary of Job.' }
		expose :max_salary, documentation: { type: 'Integer', desc: 'Max Salary of Job.' }
		expose :bonus, documentation: { type: 'Integer', desc: 'Money Bonus of Job.' }
		expose :bonus_for_dev, documentation: { type: 'Integer', desc: 'Money Bonus of Job.' }
		expose :display_pulse, documentation: { type: 'Boolean', desc: 'Display Boolean.' }
		expose :commission, documentation: { type: 'String', desc: 'Job Commission' }
	end
end