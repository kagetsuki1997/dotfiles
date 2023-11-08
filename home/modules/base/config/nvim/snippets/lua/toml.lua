return {
    parse(
        "async",
        [[
async-trait = "0.1"
futures = "0.3"
tokio = { version = "1", features = ["fs", "rt-multi-thread", "signal", "sync", "time"] }
tokio-util = { version = "0.7", features = ["io"] }

]]
    ),

    parse(
        "serde",
        [[
serde = { version = "1", features = ["derive"] }
serde_json = "1"
serde_yaml = "0.8"

]]
    ),

    parse(
        "tracing",
        [[
tracing = "0.1"
tracing-opentelemetry = "0.17"
tracing-subscriber = { version = "0.3", features = ["env-filter"] }

]]
    ),

    parse(
        "http",
        [[
axum = { version = "0.5", features = ["headers"] }
reqwest = { version = "0.11", default-features = false }
tower-http = { version = "0.3", features = ["trace", "compression-full"] }

]]
    ),

    parse(
        "misc",
        [[
ahash = "0.8"
base64 = "0.13"
bytes = "1"
chrono = { version = "0.4", features = ["serde"]}
clap = { version = "3", features = ["derive", "env"] }
clap_complete = "3"
humantime = "2"
lazy_static = "1"
mimalloc = "0.1"
snafu = { version = "0.7", default-features = false, features = ["std", "futures"] }
url = { version = "2", features = ["serde"] }
uuid = "1"

]]
    ),
}
