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
        elsif call.start_with? "POTS:"
          pots_line(call)
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

    def pots_line(line)
      pots_det = {
          id:    line.match(/^POTS: [0-9]*/).to_s.gsub!(/POTS: /, ''),
          count: line.match(/Chans=[0-9]*/).to_s.gsub!(/Chans=/, '')
      }
      @pots << pots_det
    end

    def ras_line(line)
      ras_det = {
          id:    line.match(/^RAS: [0-9]*/).to_s.gsub!(/RAS: /, ''),
          count: line.match(/Chans=[0-9]*/).to_s.gsub!(/Chans=/, '')
      }
      @ras << ras_det

    end

    def sip_line(line)

      sip_det = {
          id:      line.match(/^SIPLine: [0-9]*/).to_s.gsub!(/SIPLine: /, ''),
          count:   line.match(/Chans=[0-9]*/).to_s.gsub!(/Chans=/, ''),
          used:    line.match(/Used=[0-9]*/).to_s.gsub!(/Used=/, ''),
          version: line.match(/Version=.*/).to_s.gsub!(/Version=/, '')
      }
      @sip << sip_det
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
      matches = line =~ /CALL: ([0-9.]*) State=([0-9]*) Cut=([0-9]*) Music=([(0-9.)]*) Aend="([\S\s]*)" \(([0-9.]*)\) Bend="([\S\s]*)" \[([\S\s]*)\] \(([0-9.]*)\) CalledNum=([\S\s]*) \(([\S\s]*)\) CallingNum=([\S\s]*) \(([\S\s]*)\) Internal=([0-9]*) Time=([0-9]*) AState=([0-9]*)/
      call_id             = $1
      state               = $2
      cut                 = $3
      music               = $4
      a_end               = $5
      a_end_value         = $6
      b_end               = $7
      b_end_desc          = $8
      b_end_value         = $9
      called_number       = $10
      called_number_desc  = $11
      calling_number      = $12
      calling_number_desc = $13
      internal            = $14
      time                = $15
      astate              = $16

      # puts call_id
      puts $5
      puts $6
      #  puts $7
      #  puts $8


      call_det= {
          call_id:          call_id,
          state:            state,
          cut:              cut,
          music:            music,
          a_end:            a_end,
          a_end_value:      a_end_value,
          b_end:            b_end,
          b_end_value:      b_end_value,
          b_end_desc:       b_end_desc,
          called_num:       called_number,
          called_num_desc:  called_number_desc,
          calling_num:      calling_number,
          calling_num_desc: calling_number_desc,
          internal:         internal,
          time:             time,
          astate:           astate
      }

      @calls << call_det

    end
  end
end
