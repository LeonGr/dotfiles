# Aliases
alias cr='echo "alias: cargo run"; cargo run'
#compdef _cargo cr=cargo-run
alias crr='echo "alias: cargo run --release"; cargo run --release'
#compdef _cargo crr=cargo-run
alias ci='echo "alias: cargo init"; cargo init'
#compdef _cargo ci=cargo-init
alias cf='echo "alias: cargo fmt"; cargo fmt'
#compdef _cargo cf=cargo-fmt
alias cfl='echo "alias: cargo flamegraph"; cargo flamegraph'
#compdef _cargo cfl=cargo-flamegraph
alias ca='echo "alias: cargo add"; cargo add'
#compdef _cargo ca=cargo-add
alias ccl='echo "alias: cargo clippy"; cargo clippy'
#compdef _cargo ccl=cargo-clippy
