part of '../service_mock.dart';

const _valuePrices = [
  17.71,
  21.56,
  47.85,
  4.93,
  12.38,
  43.89,
  72.1,
  95.25,
  86.66,
  96.12,
  49.03,
  64.31,
  60.12,
  23.44,
  34.47,
  97.01,
  48.6,
  83.58,
  39.79,
  58.14,
  51.12,
  11.48,
  45.39,
  67.76,
  71.2,
  5.76,
  38.12,
  74.44,
  71.18,
  73.73,
  52.47,
  72.41,
  52.77,
  63.02,
  23.16,
  46.68,
  54.93,
  39.88,
  17.26,
  91.76,
  75.51,
  29.67,
  48.67,
  72.04,
  13.04,
  31.26,
  19.26,
  94.88,
  13.67,
  40.93,
  45.1,
  80.55,
  76.27,
  50.5,
  41.45,
  67.1,
  19.52,
  36.72,
  72.34,
  87.94,
  81.49,
  13.64,
  85.12,
  66.97,
  84.69,
  63.86,
  88.09,
  93.71,
  92.35,
  77.64,
  93.78,
  30.01,
  32.44,
  87.77,
  69.73,
  58.24,
  83.46,
  84.56,
  66.17,
  38.71,
  64.27,
  91.18,
  80.95,
  45.02,
  80.46,
  19.53,
  38.6,
  90.29,
  23.25,
  81.82,
  47.97,
  57.73,
  48.98,
  53.34,
  43.65,
  10.92,
  35.22,
  79.88,
  26.67,
  41.56,
  54.05,
  68.49,
  97.6,
  36.88,
  87.71,
  18.92,
  71.81,
  66.32,
  45.07,
  66.7,
  34.13,
  76.22,
  71.25,
  83.88,
  68.97,
  23.01,
  84.16,
  50.6,
  45.89,
  43.67,
  10.51,
  47.4,
  77.99,
  11.17,
  75.16,
  21.88,
  99.06,
  72.24,
  70.42,
  50.71,
  98.9,
  71.57,
  29.46,
  69.32,
  48.76,
  53.64,
  29.94,
  39.62,
  33.28,
  73.2,
  16.07,
  70.5,
  41.41,
  88.01,
  33.97,
  35.12,
  44.54,
  32.17,
  25.68,
  95.26,
  86.48,
  45.3,
  62.64,
  54.25,
  39.06,
  63.4,
  85.52,
  72.61,
  85.02,
  18.47,
  77.1,
  83.46,
  88.17,
  54.43,
  25.82,
  78.21,
  60.77,
  85.15,
  46.53,
  33.94,
  88.45,
  39.05,
  69.25,
  27.77,
  79.42,
  43.19,
  46.56,
  78.32,
  57.62,
  73.92,
  57.39,
  70.06,
  62.29,
  89.62,
  41.38,
  85.39,
  10.01,
  70.28,
  75.39,
  64.02,
  93.34,
  93.32,
  77.33,
  60.35,
  74.8,
  71.97,
  88.0,
  43.14,
  82.52,
  88.22,
  85.98,
  83.22,
  34.62,
  55.0,
  97.53,
  63.27,
  52.25,
  70.41,
  28.24,
  86.3,
  88.23,
  98.86,
  63.42,
  68.61,
  52.96,
  44.92,
  35.65,
  91.45,
  91.45,
  55.9,
  61.22,
  70.56,
  83.89,
  25.36,
  76.09,
  67.03,
  89.34,
  70.95,
  74.06,
  81.69,
  79.23,
  49.3,
  27.52,
  73.4,
  75.21,
  37.09,
  51.23,
  17.89,
  81.86,
  36.36,
  58.48,
  69.2,
  68.98,
  33.9,
  38.02,
  95.97,
  39.43,
  68.46,
  90.47,
  32.67,
  82.15,
  89.22,
  74.35,
  26.91,
  33.03,
  47.24,
  53.65,
  75.92,
  20.49,
  73.22,
  98.64,
  46.29,
  46.94,
  26.36,
  82.99,
  74.96,
  52.55,
  81.88,
  98.47,
  86.99,
  30.23,
  79.67,
  77.46,
  96.65,
  41.69,
  80.99,
  76.97,
  80.34,
  23.41,
  60.24,
  51.98,
  97.48,
  82.77,
  79.11,
  97.71,
  44.43,
  23.2,
  30.09,
  70.47,
  78.82,
  48.06,
  31.05,
  26.32,
  26.04,
  57.38,
  35.9,
  29.34,
  93.13,
  54.12,
  56.67,
  63.06,
  56.64,
  89.77,
  85.47,
  97.44,
  35.18,
  89.43,
  81.1,
  31.19,
  29.04,
  33.1,
  63.7,
  66.7,
  94.19,
  99.69,
  49.42,
  61.25,
  40.67,
  42.8,
  63.3,
  96.4,
  48.26,
  85.14,
  66.71,
  79.84,
  80.9,
  40.32,
  44.11,
  88.92,
  60.88,
  96.07,
  23.41,
  30.34,
  29.43,
  25.28,
  85.07,
  72.36,
  29.03,
  29.69,
  35.95,
  60.67,
  80.67,
  44.13,
  88.85,
  45.43,
  52.71,
  75.89,
  40.92,
  69.08,
  44.44,
  65.34,
  38.5,
  55.01,
  35.56,
  92.05,
  59.97,
  84.63,
  91.1,
  47.2,
  80.19,
  45.14,
  40.79,
  45.53,
  86.25,
  44.09,
  84.91,
  85.0,
  38.69,
  52.64,
  72.56,
  84.32,
  55.19,
  56.46,
  68.99,
  59.82,
  65.92,
  44.28,
  83.06,
  93.22,
  31.56,
  67.13,
  38.95,
  65.47,
  39.6,
  64.11,
  92.15,
  83.44,
  66.06,
  34.57,
  88.47,
  63.63,
  81.9,
  58.63,
  86.71,
  65.01,
  49.36,
  45.68,
  76.44,
  89.42,
  32.35,
  90.86,
  53.56,
  54.24,
  92.0,
  35.31,
  98.09,
  63.01,
  38.4,
  67.17,
  87.06,
  70.1,
  59.35,
  78.15,
  60.97,
  37.49,
  82.78,
  67.79,
  97.55,
  88.64,
  80.91,
  45.46,
  38.42,
  76.95,
  56.4,
  58.79,
  25.7,
  61.69,
  77.01,
  66.26,
  46.91,
  43.63,
  93.43,
  42.41,
  94.79,
  78.89,
  93.33,
  38.86,
  52.46,
  66.72,
  75.85,
  74.76,
  38.92,
  60.41,
  71.85,
  57.77,
  55.29,
  89.68,
  41.4,
  86.55,
  67.57,
  91.95,
  43.51,
  94.35,
  93.9,
  72.48,
  97.8,
  63.28,
  98.06,
  42.91,
  99.58,
  71.78,
  57.51,
  34.46,
  60.69,
  95.47,
  42.0,
  68.33,
  45.82,
  95.28,
  71.07,
  87.24,
  52.95,
  97.14,
  88.19,
  67.18,
  66.86,
  32.17,
  81.76,
  98.07,
  63.63,
  69.13,
  83.06,
  67.56,
  45.14,
  89.7,
  99.28,
  74.4,
  97.84,
  35.61,
  39.44,
  61.49,
  47.55,
  90.65,
  93.35,
  71.58,
  66.95,
  92.38,
  57.91,
  66.57,
  64.8,
  67.05,
  55.3,
  75.36,
  41.96,
  82.28,
  49.18,
  68.38,
  39.57,
  70.78,
];
