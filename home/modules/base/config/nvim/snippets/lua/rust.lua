return {
    parse(
        "inline",
        [[#[inline]
]]
    ),
    parse(
        "mustuse",
        [[#[must_use]
]]
    ),

    parse(
        "newstruct",
        [[
#[derive(Clone, Debug, Default)]
struct A {

}

impl A {
    #[inline]
    pub fn new() -> Self {
        Self {

        }
    }
}]]
    ),

    parse(
        "newmodel",
        [[
#[derive(Clone, Debug, Default, Deserialize, Eq, PartialEq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct MyModel { }]]
    ),

    parse(
        "newasynctrait",
        [[
#[async_trait]
pub trait AsyncTrait {
    async fn do_something();
}]]
    ),

    parse(
        "newcli",
        [[
use std::io::Write;

use clap::{IntoApp, Parser, Subcommand};
use clap_complete::Shell;

#[derive(Args, Debug)]
pub struct Config {
    pub option: String
}

#[derive(Debug, Parser)]
#[clap(about, author, version)]
pub struct Cli {
    #[clap(subcommand)]
    commands: Commands,
}

impl Default for Cli {
    #[inline]
    fn default() -> Self { Self::parse() }
}

#[derive(Debug, Subcommand)]
enum Commands {
    #[clap(about = "Show version of this auth")]
    Version,

    #[clap(about = "Generate shell completion")]
    Completions { shell: Shell },

    #[clap(about = "Run APP")]
    Run {
        #[clap(flatten)]
        config: Box<Config>,
    },
}

impl Cli {
     pub fn run(self) -> Result<()> {
         match self.commands {
             Commands::Version => {
                 let mut stdout = std::io::stdout();
                 stdout
                     .write_all(Self::command().render_long_version().as_bytes())
                     .expect("failed to write to stdout");
                 Ok(())
             }
             Commands::Completions { shell } => {
                 let mut app = Self::command();
                 let bin_name = app.get_name().to_string();
                 clap_complete::generate(shell, &mut app, bin_name, &mut std::io::stdout());
                 Ok(())
             }
             Commands::Run { config } => {
                Ok(())
             }
         }
     }
}]]
    ),

    parse(
        "snafuerror",
        [[
use snafu::{Backtrace, Snafu};

pub type Result<T> = std::result::Result<T, Error>;

#[derive(Debug, Snafu)]
#[snafu(visibility(pub))]
pub enum Error {
    #[snafu(display("Error occurs while doing, error: {source}"))]
    Error1 { value: String, source: TheError, backtrace: Backtrace },
}]]
    ),

    parse(
        "errorvariant",
        [[
    #[snafu(display("Error occurs while doing, error: {source}"))]
    Error { value: String, source: Error, backtrace: Backtrace },]]
    ),

    parse(
        "usestdpath",
        [[use std::path::{Path, PathBuf};
]]
    ),
    parse(
        "usestdfmt",
        [[use std::fmt;
]]
    ),
    parse(
        "usestdtimedur",
        [[use std::time::Duration;
]]
    ),
    parse(
        "usestdphantom",
        [[use std::marker::PhantomData;
]]
    ),
    parse(
        "usestdhashmap",
        [[use std::collections::HashMap;
]]
    ),
    parse(
        "usestdhashset",
        [[use std::collections::HashSet;
]]
    ),
    parse(
        "usestdintoiter",
        [[use std::iter::IntoIterator;
]]
    ),
    parse(
        "useserde",
        [[use serde::{Deserialize, Serialize};
]]
    ),
    parse(
        "useasynctrait",
        [[use async_trait::async_trait;
]]
    ),
    parse(
        "usetokiomutex",
        [[
    use std::sync::Arc;

    use tokio::sync::Mutex;
]]
    ),
    parse(
        "usetokiorwlock",
        [[
    use std::sync::Arc;

    use tokio::sync::RwLock;
]]
    ),
    parse(
        "usetokiooneshot",
        [[
    use tokio::sync::oneshot;
]]
    ),
    parse(
        "usetokiompsc",
        [[
    use tokio::sync::mpsc;
]]
    ),

    parse("tokiosleep", [[tokio::time::sleep(Duration::from_millis(200)).await;]]),

    parse("fmt", [[format!("{}");]]),

    parse("tracingtrace", [[tracing::trace!("");]]),
    parse("tracingdebug", [[tracing::debug!("");]]),
    parse("tracinginfo", [[tracing::info!("");]]),
    parse("tracingwarn", [[tracing::warn!("");]]),
    parse("tracingerror", [[tracing::error!("");]]),

    parse(
        "froma",
        [[
impl From<A> for B {
    #[inline]
    fn from(a: A) -> Self {
        Self { }
    }
}]]
    ),

    parse(
        "derivehash",
        [[use std::hash::{Hash, Hasher};

impl Hash for A {
    fn hash<H>(&self, state: &mut H)
    where
        H: Hasher,
    {
        // self.id.hash(state);
    }
}]]
    ),
}
