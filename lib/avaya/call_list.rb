module Avaya
  class CallList
    attr_reader :all_calls, :name, :ras, :pots, :sip, :q93

    def initialize

      @ras       = []
      @pots      = []
      @sip       = []
      @q93       = []
      @all_calls = Avaya::TFTP.read(:call_list)

    end

    def self.get
      call_list = self.new
      call_list.get

    end

    def get

      #items = @all_calls.collect { |row| row.gsub(/Line /, 'Line_').split(' ') }
      @all_calls.each do |call|
        case call
          when call.starts_with? "NAME:"
            @name = call.gsub!("NAME: ", '').gsub!('"', '')
          when call.starts_with? "RAS:"
            ras_line(call)
          when call.starts_with? "SIPLine:"
            sip_line(call)
          when call.starts_with? "Q93Line:"
            q93_line(call)

          when call.starts_with? "CALL:"
            call_line(call)
        end

      end

    end

    def ras_line(line)
      line    = line.split(' ')
      ras_det = {
          id:    line[0].gsub!(/NAME: /, ''),
          count: line[0].gsub!(/Chans=/, '')
      }
      @ras.merge! ras_det

    end

    def sip_line(line)
      line     = line.split(' ')
      pots_det = {
          id:    line[0].gsub!(/POTS: /, ''),
          count: line[1].gsub!(/Chans=/, ''),
          used:  line[2].gsub!(/Used=/, ''),
      }
      @pots.merge! pots_det
    end

    def q93_line(line)

      line    = line.split.gsub(/Q931 PRI TE Version /, 'Q931_PRI_TE_Version_').split(' ')
      q93_det = {
          id:      line[0].gsub!(/NAME: /, ''),
          count:   line[1].gsub!(/Chans=/, ''),
          used:    line[2].gsub!(/Used=/, ''),
          version: line[4].gsub!(/Version=/, '').gsub!('_', ' ')
      }
      @q93.merge! q93_det
    end

    def call_line(line)
      line     = line.gsub(/Line /, 'Line_').split(' ')
      call_det = {


      }
    end


  end

end