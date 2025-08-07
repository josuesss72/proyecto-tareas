const createStatusResponse =
  (code: number, defaulMessage: string) => (message?: string) => ({
    code,
    message: message || defaulMessage,
    ok: code >= 200 && code < 300,
  });

export const statusResponse = {
  http200: createStatusResponse(200, 'Success'),
  http201: createStatusResponse(201, 'Created'),
  http202: createStatusResponse(202, 'Accepted'),
  http204: createStatusResponse(204, 'No Content'),
};
