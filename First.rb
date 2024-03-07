# Welcome to Sonic Pi
use_bpm 100

use_tuning :just
use_synth_defaults sustain: 32
with_fx :distortion do
  with_fx :ixi_techno, phase: 16 do
    s0 = synth :tri, note: 36, pan: 1
    s1 = synth :sine, note: 24, pan: -1
    s2 = synth :tri, note: 24, pan: 1
  end
  with_fx :slicer, phase: 4 do
    s3= synth :tri, note: 60, amp: 0.5
  end
end

live_loop :kick do
  sample  :bd_haus ,amp: 1
  sleep 1
end


live_loop :hh_cc do
  sample :drum_cymbal_closed, amp: 0.6, sustain: 32
  sleep 0.75
end

live_loop :hh_op do
  
  sample :drum_cymbal_hard, amp: 0.5, sustain: 32
  sleep 0.5
end



