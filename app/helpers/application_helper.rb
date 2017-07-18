module ApplicationHelper

  def get_color_of_categories_td (category_stats, sym)
    case sym
      when :earned
        case
          when category_stats[sym]!=0 then "<td style=\"color: #008000;\">#{category_stats[sym]}</td>".html_safe
          else "<td>#{category_stats[sym]}</td>".html_safe
        end
      when :spent
        case
          when category_stats[sym]!=0 then "<td style=\"color: #B22222;\">#{-category_stats[sym]}</td>".html_safe
          else "<td>#{category_stats[sym]}</td>".html_safe
        end
      when :summary
        case
          when category_stats[sym]>0 then "<td style=\"color: #008000;\">#{category_stats[sym]}</td>".html_safe
          when category_stats[sym]<0 then "<td style=\"color: #B22222;\">#{-category_stats[sym]}</td>".html_safe
          else "<td>#{category_stats[sym]}</td>".html_safe
        end
    end
  end

  def get_color_of_transactions_td (transaction)
    case transaction.direction
      when true then "<td style=\"color: #008000;\">#{transaction.value}</td>".html_safe
      else "<td style=\"color: #B22222;\">#{-transaction.value}</td>".html_safe
    end
  end

  def get_account_money
    Account.find(current_user.id).money
  end

end
