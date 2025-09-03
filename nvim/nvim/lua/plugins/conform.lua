return {
    { "cherrry/soong.vim" },
    { "alexander-born/bazel.nvim" },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                clangd = {
                    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
                },
            },
            opts = {
                autoformat = true,
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                sh = { "shfmt" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                java = { "google-java-format" },
            },
        },
    },
}
