##| live_loop :main do
##|   sample :bass_dnb_f
##|   with_fx :bitcrusher, sample_rate: 10 do
##|     sample :bass_dnb_f, lpf: 130, amp: 2
##|     sleep 2
##|   end
##| end



# holy shit how the fuck is this possible???
#live_loop :main do
#  sample :bass_dnb_f
#  sleep 0.5
#end


live_loop :bd do
  density (knit, 2, 16, 4 ,2).tick do
    sample :bd_ada, cutoff: 80, amp: 3
    with_fx :bitcrusher, sample_rate: 5000 do
      sample :bass_dnb_f, release: 0, finish: 0.3, pitch: 0, amp: 1
      sleep 1
    end
  end
end


live_loop :bda do
  density (knit, 1, 8,4 ,1).tick do
    sample :bd_ada, cutoff: 80, amp: 3
    sleep 1
  end
end


live_loop :hats do
  if (spread 5, 9).tick then
    with_synth :pnoise do
      play :d1, attack: 0.05, decay: 0.08, release: 0.1, amp: 1.5
    end
  end
  sleep 1
end

live_loop :crash, sync: :bda do
  density (knit, 1, 1,0 ,8).tick do
    sample :drum_splash_hard, attack: 0.05, decay: 0.08, release: 0.1, amp: 1.5
    sleep 1
  end
end







##| live_loop :bassone do
##|   with_fx :distortion, distort: 0.4, pre_amp: 1, mix:0.8, pre_mix: 1 do
##|     with_fx :ixi_techno, cutoff_max: 110, phase_offset: 0.5 do
##|       with_fx :compressor, clamp_time: 1, pre_amp: 3, slope_above: 4 do
##|         with_synth :sine do
##|           play_pattern_timed [:c1, :c1, :c1, :c1, :g1, :g1, :g1, :fs1, :fs1, :fs1],
##|             [1,1,1,1, 0.5, 1, 1, 1, 1, 1, 1],
##|             sustain: 0.2, release: 0.3, amp: 1, pan:-0.51
##|         end
##|       end
##|     end
##|   end
##| end


##| live_loop :bassone do
##|   with_fx :distortion, distort: 0.4, pre_amp: 1, mix:0.8, pre_mix: 1 do
##|     with_fx :ixi_techno, cutoff_max: 110, phase_offset: 0.5 do
##|       with_fx :compressor, clamp_time: 1, pre_amp: 3, slope_above: 4 do
##|         with_synth :dsaw do
##|           play_pattern_timed [:cs1, :cs1, :cs1, :cs1, :gs1, :e1, :b1, :fs1, :b1, :ds1],
##|             [0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1, 1, 1],
##|             sustain: 0.3, release: 0.5, amp: 1, pan:-0.51
##|         end
##|       end
##|     end
##|   end
##| end





##| live_loop :main do
##|   with_fx :bitcrusher, sample_rate: 5000 do
##|     sample :bass_dnb_f, release: 0, finish: 0.3, pitch: 0, amp: 1
##|     sleep 0.5
##|   end
##| end


in_thread do
  use_synth :dsaw
  with_fx :bitcrusher, sample_rate: 5000 do
    24.times do
      play_pattern_timed [:cs4, :a3, :e3, :gs2, :e2, :b2, :fs3, :b3, :ds4],
        [1,1,1,1,1,1,1,1,1],
        sustain: 0.5, release: 0.9, amp: 1, pan:-0.51
    end
  end
end


live_loop :strings, sync: :bda do
  use_synth :supersaw
  with_fx :rhpf, cutoff: 60, mix: 0.5 do
    play_chord [:cs4, :a3, :e3, :gs2], sustain: 4, release: 0.5, attack: 0.5, amp: 1
    sleep 4
    play_chord [:e2, :b2, :fs3, :b3, :ds4], sustain: 5, release: 0.5, attack: 0.8, amp: 1.5
    sleep 5
  end
end





##| live_loop :grove do
##|   sync :main
##|   sample :loop_amen_full, cutoff: 80, amp: 1
##|   sleep 3
##| end
