filename = 'input.txt'

def analyse(filename, worker_count, step_time)
  steps = open(filename).readlines.map { |e| e.scan(/ ([A-Z]) /).flatten }
  last  = steps.map(&:last).uniq - steps.map(&:first).uniq
  order = Array.new
  work_in_progress    = Array.new(worker_count, nil)
  seconds_in_progress = Array.new(worker_count, 0)
  time_taken = 0

  while steps.size > 0
    # Check if got available worker
    available_worker = seconds_in_progress.index(0)

    #  Find available steps
    before = steps.map(&:first).uniq
    after  = steps.map(&:last).uniq
    available_steps = (before - after).sort
    available_steps = available_steps - work_in_progress
    
    while available_steps.size > 0 && available_worker

      # Select first alphabet
      chosen = available_steps.first

      # Assign to available worker
      work_in_progress[available_worker]    = chosen
      seconds_in_progress[available_worker] = chosen.ord - 64 + step_time

      # Update available steps and available workers
      available_steps.shift
      available_worker = seconds_in_progress.index(0)
    end

    time_taken += 1
    seconds_in_progress.map! { |e| e > 0 ? e - 1 : e }
    (0...worker_count).each do |i|
      if seconds_in_progress[i] == 0
        # Remove after finish work
        steps.reject! { |step| step.first == work_in_progress[i] }
        work_in_progress[i] = nil
      end
    end

  end

  time_taken + last[0].ord - 64 + step_time
end

worker_count = 5
step_time = 60
puts "It would take #{analyse(filename, worker_count, step_time)} seconds for #{worker_count} workers to complete these steps"