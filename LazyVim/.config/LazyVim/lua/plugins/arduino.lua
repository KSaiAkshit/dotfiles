local M = {
  "stevearc/vim-arduino",
  ft = "arduino",
  keys = {
    { "<leader>aa", "<cmd>ArduinoAttach<CR>", desc = "Automatically attach to your board" },
    { "<leader>av", "<cmd>ArduinoVerify<CR>", desc = "Build the sketch" },
    { "<leader>au", "<cmd>ArduinoUpload<CR>", desc = "Build and upload the sketch" },
    { "<leader>aus", "<cmd>ArduinoUploadAndSerial<CR>", desc = "Build, upload, and connect for debugging" },
    { "<leader>as", "<cmd>ArduinoSerial<CR>", desc = "Connect to the board for debugging over a serial port" },
    {
      "<leader>ab",
      "<cmd>ArduinoChooseBoard<CR>",
      desc = "Select the type of board. With no arg, will present a choice dialog",
    },
    {
      "<leader>ap",
      "<cmd>ArduinoChooseProgrammer<CR>",
      desc = "Select the programmer. With no arg, will present a choice dialog",
    },
  },
}
return M
