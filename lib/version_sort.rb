class Array
  def version_sort
    head = [self.shift]
    tail = self
    j = 0
    until tail.empty?
      direction = compare_versions(head[0], tail[0])
      if direction == 1 || direction == 0
        head.unshift(tail.shift)
      else
        i = 0
        while i < head.size
          break if compare_versions(head[i], tail[0]) == 1
          i += 1
        end
        i == 0 ? head << tail.shift : head.insert(i, tail.shift)
      end
    end
    head
  end

  def compare_versions(a, b)
    direction = nil
    a = a.gsub(/\w+-/, "").gsub(".ext", "")
    b = b.gsub(/\w+-/, "").gsub(".ext", "")
    a_array = a.split(".")
    b_array = b.split(".")
    i = 0
    while direction.nil?
      if a_array[i].to_i < b_array[i].to_i
        direction = -1
      elsif a_array[i].to_i > b_array[i].to_i
        direction = 1
      elsif a_array[i].nil? || b_array[i].nil?
        direction = a_array[i] ? -1 : direction = 1
      elsif a_array[i].end_with?("a", "b") && !b_array[i].end_with?("a", "b")
        direction = 1
      elsif !a_array[i].end_with?("a", "b") && b_array[i].end_with?("a", "b")
        direction = -1
      elsif a_array[i].end_with?("a", "b") && b_array[i].end_with?("a", "b")
        direction = a_array[i].end_with?("a") ? -1 : 1
      elsif a_array[i].start_with?("beta")
        if b_array[i].start_with?("rc")
          direction = -1
        else
          direction = a_array[i][-1].to_i < b_array[i][-1].to_i ? -1 : 1
        end
      elsif a_array[i].start_with?("rc")
        if b_array[i].start_with?("beta")
          direction = 1
        else
          direction = a_array[i][-1].to_i < b_array[i][-1].to_i ? -1 : 1
          # binding.pry
        end
      end
      i += 1
    end
    direction
  end
end