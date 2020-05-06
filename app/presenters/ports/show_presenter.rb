module Ports
  class ShowPresenter < ApplicationPresenter
    def initialize(view_context, application_scope)
      super(view_context)
      @application_scope = application_scope
    end

    def page_title
      "Ports | Corona Safe Network"
    end

    def applications
      @applications ||= begin
        filter.includes(:contacts).order('contacts.created_at DESC').page(view.params[:page]).per(20)
      end
    end

    def filter
      search = view.params[:search]
      if search.present?
        s = search[:category].present? ? filter_by_category(scope_by_date) : scope_by_date
        search[:state].present? ? filter_by_state(s) : s
      else
        scope_by_date
      end
    end

    def date_window
      start_date.beginning_of_day..end_date.end_of_day
    end

    def default_start_date
      Time.zone.now.to_date
    end

    def start_date
      @start_date ||= view.params[:search].try(:[], :start_date) ? view.params[:search][:start_date].to_date : default_start_date
    end

    def end_date
      @end_date ||= view.params[:search].try(:[], :end_date) ? view.params[:search][:end_date].to_date : Time.zone.now.to_date
    end

    def scope_by_date
      @scope_by_date ||= @application_scope.joins(:contacts).where(contacts: { arrived_on: date_window })
    end

    def filter_by_category(applications)
      applications.where("contacts.status='#{view.params[:search][:category]}'")
    end

    def filter_by_state(consultations)
      consultations.where(state: view.params[:search][:state])
    end

    def search
      @search ||= view.params[:search]
    end

    def text_search_text
      text_search.try(:[], :vehicle_number) ? text_search[:vehicle_number] : ''
    end

    def search_category
      search.present? ? search[:category].present? ? search[:category] : nil : nil
    end

    def search_state
      search.present? ? search[:state].present? ? search[:state] : nil : nil
    end
  end
end