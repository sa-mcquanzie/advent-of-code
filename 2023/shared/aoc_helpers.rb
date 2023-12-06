module AOC_Helpers
  def run_with_timer(method, *args)
    start_time = Time.now

    method_return = method.call(*args)

    end_time = Time.now
    execution_time = end_time - start_time
    minutes = (execution_time / 60).to_i
    seconds = (execution_time % 60).to_i
    milliseconds = ((execution_time % 1) * 1000).to_i

    puts puts "\nSOLUTION:\n#{method_return}\n"
    puts "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Execution time was: #{execution_time} seconds\nor: #{minutes} minutes, #{seconds} seconds and #{milliseconds} milliseconds"
  end
end