# Configuración de los knobs MIDI

knobs = {
  attack: 0.1,
  decay: 0.5,
  sustain: 2.7,
  release: 0.5,
  echo: 0.0, # Nuevo knob para el efecto de echo
  reverb: 0.0, # Nuevo knob para el efecto de reverb
  pan: 0.5, # Nuevo knob para el panoramizado (inicialmente en el centro)
  pan: 0.5
}

live_loop :setter do
  use_real_time
  knob, value = sync "/midi:mpk_mini:1/control_change"
  case knob
  when 1
    knobs[:attack] = value / 127.0
  when 2
    knobs[:decay] = value / 127.0
  when 3
    knobs[:sustain] = value / 127.0
  when 4
    knobs[:release] = value / 127.0
  when 5
    knobs[:echo] = value / 127.0
  when 6
    knobs[:reverb] = value / 127.0
  when 8
    knobs[:pan] = value / 127.0 -1
  end
end

live_loop :synth_sine do
  use_real_time
  attack_val = knobs[:attack]
  decay_val = knobs[:decay]
  sustain_val = knobs[:sustain]
  release_val = knobs[:release]
  echo_val = knobs[:echo]
  reverb_val = knobs[:reverb]
  pan_val = knobs[:pan]
  
  note, velocity = sync "/midi:mpk_mini:1/note_on"
  
  with_fx :reverb, room: reverb_val do
    with_fx :vowel, voice: 2 , vowel_sound: 5 , mix: 0.5 do
      with_synth :dsaw do
        play note, sustain: sustain_val, release: release_val, attack: attack_val, decay: decay_val, amp: velocity / 127.0, pan: pan_val
      end
    end
  end
end






# with_fx :bitcrusher , bits: 1 , cutoff: 60 do
# with_fx :echo, decay: 2 , phase: 0.5, amp: 1 do
# with_fx :hpf cutoff: 1
# with_fx :compressor 10 , clamp_time: 1 , amp: 1
# with_fx :flanger decay: 1 ,  delay: 10 , feedback: 10 , amp: 1
# with_fx :ixi_techno, cutoff_max: 90 , cutoff_min: 50, res: 0.5 do
# with_fx :lpf cutoff: 1
# with_fx :octaver  pre_amp: 2 , pre_mix: 0.5, sub_amp: 1
# with_fx :pan amp: rrand(1,-1)
# with_fx :ping_pong feedback: 10, max_phase: 1
# with_fx :reverb damp: 1 , room: 1
# with_fx :slicer amp_max: 1 ,invert_wave: 2 ,phase: 0.5
# with_fx :vowel voice: 1 , vowel_sound: 2 , mix: 0.5
# with_fx :whammy, deltime: 10 ,grainsize: 2 ,transpose: 0.5 do
# with_fx :wobble, wave: 2 , seed: 1000 , filter: 1 ,phase: 0.9 , res: 0.9 do






