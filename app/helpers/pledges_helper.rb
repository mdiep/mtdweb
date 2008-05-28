
module PledgesHelper
    def amount_for_pledge(pledge)
        # if the amount is only dollars and no cents, don't show a decimal
        if pledge.amount % 1 == 0
            return sprintf("$%d%s", pledge.amount, Pledge.per_periods[pledge.frequency])
        else
            return sprintf("$%.2f%s", pledge.amount, Pledge.per_periods[pledge.frequency])
        end
    end
    
    def date_range_for_pledge(pledge)
        # one time pledges don't have a range
        if pledge.frequency == 'o'
            return pledge.start_date.strftime("%b %Y")
        end
        
        # pledges that are still active
        if pledge.end_date.nil?
            return pledge.start_date.strftime("%b %Y - Present");
        end
        
        # are the start and end years the same?
        if pledge.start_date.year == pledge.end_date.year
            return pledge.start_date.strftime("%b") + pledge.end_date.strftime(" - %b %Y")
        end
        
        return pledge.start_date.strftime("%b %Y") + pledge.end_date.strftime(" - %b %Y")
    end
    
    def pledges_sorted_by_date(pledges)
        # sort pledges by the date the ended and the date they started.
        # one-time gifts use the start date for both.
        return pledges.sort_by { |p| [p.frequency == 'o' ? p.start_date : p.end_date, p.start_date] }.reverse
    end
end
