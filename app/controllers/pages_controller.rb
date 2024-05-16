def to_currency(number)
  formatted_number = '%.2f' % number
  integer, decimal = formatted_number.split('.')
  integer_with_commas = integer.chars.to_a.reverse.each_slice(3).map(&:join).join(',').reverse
  "$#{integer_with_commas}.#{decimal}"
end


class PagesController < ApplicationController
  def square_new
    render(:template => "pages_templates/square_new")
  end

  def square_results
    @number = params.fetch("number").to_f
    @square = (@number ** 2)

    render(:template => "pages_templates/square_results")
  end

  def square_root_new
    render(:template => "pages_templates/square_root_new")
  end

  def square_root_results
    @number = params.fetch("number").to_f
    @square_root = Math.sqrt(@number)

    render(:template => "pages_templates/square_root_results")
  end

  def payment_new
    render(:template => "pages_templates/payment_new")
  end

  def payment_results
    apr = params.fetch("apr").to_f
    @apr = format('%.4f', apr) + '%'
    @years = params.fetch("years").to_f
    @monthly_periods = (@years * 12).to_i
    principal = params.fetch("principal").to_f.round(2)
    @principal = to_currency(principal)

    r = (apr / 100) / 12
    @numerator = r * (principal)
    @denominator = 1 - ((1 + r) ** -@monthly_periods)

    @payment = (@numerator / @denominator)
    @payment = to_currency(@payment)

    render(:template => "pages_templates/payment_results")
  end

  def random_new
    render(:template => "pages_templates/random_new")
  end

  def random_results
    @min = params.fetch("user_min").to_f
    @max = params.fetch("user_max").to_f

    @result = rand(@min..@max)

    render(:template => "pages_templates/random_results")
  end
end
