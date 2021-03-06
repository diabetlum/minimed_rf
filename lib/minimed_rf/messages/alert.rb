
module MinimedRF

  AlertCodes = {
    0x33 => :max_hourly_bolus,
    0x72 => :high_predicted
  }

  class Alert < Message

    # Max hourly bolus
    # 2014-09-08T22:01:09-0500 - a2 350535 01 e3 33 153b1d 0e 09 08 5200 d8

    def self.bit_blocks
      {
        sequence: [0,8],
        alert_type: [8,8]
      }
    end

    def sequence
      b(:sequence)
    end

    def alert_type
      AlertCodes[b(:alert_type)]
    end

    def alert_type_str
      case alert_type
      when :max_hourly_bolus
        "MaxHourlyBolus"
      when :high_predicted
        "HighPredicted"
      end
    end

    def to_s
      "Alert: ##{sequence} #{alert_type_str}"
    end
  end
end
