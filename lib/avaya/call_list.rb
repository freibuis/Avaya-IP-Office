module Avaya
  class CallList
    attr_reader :raw,
                :name,
                :ras,
                :pots,
                :sip,
                :q93,
                :calls

    def initialize

      @ras   = []
      @pots  = []
      @sip   = []
      @q93   = []
      @calls = []
      @raw   = Avaya::TFTP.read(:call_list)

    end

    def self.get
      call_list = self.new
      call_list.get
      call_list
    end

    def get

      #items = @all_calls.collect { |row| row.gsub(/Line /, 'Line_').split(' ') }
      @raw.each do |call|
        if call.start_with?("NAME: ")
          @name = call.gsub!('NAME: ', '').gsub!('"', '')
        elsif call.start_with? "RAS:"
          ras_line(call)
        elsif call.start_with? "SIPLine:"
          sip_line(call)
        elsif call.start_with? "Q931Line:"
          q93_line(call)

        elsif call.start_with? "CALL:"
          call_line(call)
        end

      end

    end

    def ras_line(line)
      ras_det = {
          id:    line.match(/^RAS: [0-9]*/).to_s.gsub!(/RAS: /, ''),
          count: line.match(/Chans=[0-9]*/).to_s.gsub!(/Chans=/, '')
      }
      @ras << ras_det

    end

    def sip_line(line)
      pots_det = {
          id:    line.match(/^SIPLine: [0-9]*/).to_s.gsub!(/SIPLine: /, ''),
          count: line.match(/Chans=[0-9]*/).to_s.gsub!(/Chans=/, ''),
          used:  line.match(/Used=[0-9]*/).to_s.gsub!(/Used=/, ''),
      }
      @pots << pots_det
    end

    def q93_line(line)

      q93_det = {
          id:      line.match(/^Q931Line: [0-9]*/).to_s.gsub!(/Q931Line: /, ''),
          count:   line.match(/Chans=[0-9]*/).to_s.gsub!(/Chans=/, ''),
          used:    line.match(/Used=[0-9]*/).to_s.gsub!(/Used=/, ''),
          version: line.match(/Version=.*/).to_s.gsub!(/Version=/, '')
      }
      @q93 << q93_det
    end

    def call_line(line)
      call_det= {
          call_id:     line.match(/^CALL: [0-9.]*/).to_s.gsub!(/CALL: /, ''),
          state:       line.match(/ State=[0-9]*/).to_s.gsub!(/ State=/, ''),
          cut:         line.match(/Cut=[0-9]*/).to_s.gsub!(/Cut=/, ''),
          music:       line.match(/Music=[0-9.]*/).to_s.gsub!(/Music=/, ''),
          a_end:       line.match(/Aend=[a-zA-Z0-9"()]*\s[()0-9.]*/).to_s.gsub!(/Aend=/, ''),
          b_end:       line.match(/Bend=[a-zA-Z0-9"()]*\s[\[\]a-zA-Z0-9()]*\s[0-9().]*/).to_s.gsub!(/Bend=/, ''),
          called_num:  line.match(/CalledNum=[0-9]*\s[()a-zA-Z0-9]*/).to_s.gsub!(/CalledNum=/, ''),
          calling_num: line.match(/CallingNum=[0-9]*\s[()a-zA-Z0-9]*/).to_s.gsub!(/CallingNum=/, ''),
          internal:    line.match(/Internal=[0-9]*/).to_s.gsub!(/Internal=/, '').to_i,
          time:        line.match(/Time=[0-9]*/).to_s.gsub!(/Time=/, '').to_i,
          astate:      line.match(/AState=[0-9]*/).to_s.gsub!(/AState=/, '').to_i
      }

      @calls << call_det

    end
  end
end
