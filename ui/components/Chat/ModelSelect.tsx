import { IconExternalLink } from '@tabler/icons-react';
import { useContext, useEffect, useState } from 'react';

import { useTranslation } from 'next-i18next';

import { OpenAIModel } from '@/types/openai';

import HomeContext from '@/pages/api/home/home.context';

export const ModelSelect = () => {
  const [isFirstLoad, setFirstLoad] = useState(true);
  const { t } = useTranslation('chat');

  const {
    state: { selectedConversation, models, defaultModelId },
    handleUpdateConversation,
    dispatch: homeDispatch,
  } = useContext(HomeContext);

  const handleModelIdChange = (modelId: string) => {
    selectedConversation &&
      handleUpdateConversation(selectedConversation, {
        key: 'model',
        value: models.find(
          (model) => model.id === modelId,
        ) as OpenAIModel,
      });
  };

  const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => handleModelIdChange(e.target.value);

  const defaultValue = selectedConversation?.model?.id || defaultModelId;

  const value = models.findIndex(model => model.id === defaultValue) < 0 && models.length > 0 ? models[0].id : defaultValue;

  useEffect(() => {
    if (value && value !== selectedConversation?.model?.id) {
      handleModelIdChange(value);
    }
  }, [value, selectedConversation]);

  return (
    <div className="flex flex-col">
      <label className="mb-2 text-left text-neutral-700 dark:text-neutral-400">
        {t('Model')}
      </label>
      <div className="w-full rounded-lg border border-neutral-600 bg-transparent pr-2 text-neutral-900 dark:border-neutral-700 dark:text-white">
        <select
          className="w-full bg-transparent p-2"
          placeholder={t('Select a model') || ''}
          value={value}
          onChange={handleChange}
        >
          {models.map((model) => (
            <option
              key={model.id}
              value={model.id}
              className="dark:bg-[#1d1c21] dark:text-white"
            >
              {model.id === defaultModelId
                ? `Default (${model.name})`
                : model.name}
            </option>
          ))}
        </select>
      </div>
      {/* <div className="w-full mt-3 text-left text-neutral-700 dark:text-neutral-400 flex items-center">
        <a
          href="https://platform.openai.com/account/usage"
          target="_blank"
          className="flex items-center"
        >
          <IconExternalLink size={18} className={'inline mr-1'} />
          {t('View Account Usage')}
        </a>
      </div> */}
    </div>
  );
};
